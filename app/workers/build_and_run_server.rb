require "socket"
require "fileutils"
require "ostruct"

class BuildAndRunServer
  include Sidekiq::Worker
  PORT_RANGE = 2500..3000

  def perform( id )
    @host_ip = ""
    @server = Server.find(id)
    @port = find_open_port

    begin
      @container = Docker::Container.create("Image" => "atomical/sapp",
        "Tty" => true,
        "Volumes" => { "/haloded/maps" => { Settings.maps_path => "ro" } },
        "ExposedPorts" => { "#{@port}/udp" => {} },
        "Ports" => [{"PublicPort": @port.to_s, "Type": "udp"},],
        "HostConfig" => {
          "PublishAllPorts": true,
          "PortBindings" => {
            "#{@port}/udp" => [{"HostIp" => @host_ip, "HostPort" => @port.to_s }],
          },
          "Binds" => ["#{Settings.maps_path}:/haloded/maps:ro"],
        },
      )
      @container.start
    rescue Exception => e
      Rails.logger.error("Exception for server #{id}: Container: #{@container.inspect} \n #{e.inspect}")
      @server.status = ServerStatus::Failed
      @server.save!
      return
    end

    @server.container_id = @container.json["Id"]
    @server.port = @port
    @server.save

    build_server
    run_server

    @server.update_attribute(:status, ServerStatus::Running)
  end

  private

  def build_server
    copy_manifest_files
  end

  def copy_manifest_files
    init_manifest = build_init_manifest
    sapp_manifest = build_sapp_manifest
    map_cycle = build_map_cycle

    Rails.logger.debug("Manifest: #{init_manifest}")
    Rails.logger.debug("SAPP Manifest: #{sapp_manifest}")
    Rails.logger.debug("Mapcycle: `#{map_cycle}`")

    @container.store_file("/haloded/init.txt", init_manifest)
    @container.store_file("/haloded/sapp/init.txt", sapp_manifest)
    @container.store_file("/haloded/sapp/mapcycle.txt", map_cycle)

  end

  def build_init_manifest
    path = File.join(Rails.root,"app/views/server_manifests/init.html.haml")
    Haml::Engine.new(File.read(path)).render(@server)
  end

  def build_sapp_manifest
    path = File.join(Rails.root,"app/views/server_manifests/sapp/init.html.haml")
    obj = OpenStruct.new(server: @server)

    Haml::Engine.new(File.read(path)).render(obj)
  end

  def build_map_cycle
    map_name = File.basename(@server.map.filename,File.extname(@server.map.filename))
    "#{map_name}:ctf"
  end

  def find_open_port
    port = nil
    PORT_RANGE.each do |p|
      if ! PortCheck.udp_open?("localhost", p)
        port = p
        break
      end
    end
    port
  end

  def run_server
    @container.exec(["wine","/haloded/haloded.exe", "-path",
      "/haloded/", "-port", @port.to_s], detach: should_detach?){ |stream, chunk| puts "#{stream}: #{chunk}" }
    # @container.exec(["example_server"], detach: true)
  end

  def should_detach?
    true
  end

  def host_ip
    Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
  end
end