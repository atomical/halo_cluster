class ServersController < ApplicationController
  load_and_authorize_resource

  def new
    @server.set_defaults
  end

  def index
    @servers = current_user.servers.includes(:map)
  end

  def create
    @server.user = current_user
    if @server.save
      redirect_to @server
    else
      render "new"
    end
  end

  def start
    BuildAndRunServer.new.perform(@server.id)

    # BuildAndRunServer.perform_async(@server.id)
    redirect_to server_path(@server)
  end

  def stop
    begin
      c = Docker::Container.get(@server.container_id)
      c.stop
      c.delete( force: true )
    rescue Docker::Error::NotFoundError => e
      logger.error("Attempted to stop server container that cannot be found:
        #{@server.id}: #{@server.container_id} ")
    rescue Docker::Error::ServerError => e
      logger.error("Attempted to stop server with error: #{e}")
    end
    @server.container_id = nil
    @server.status = ServerStatus::Offline
    @server.save!
    redirect_to server_path(@server)
  end

  def logs
    d = Docker::Container.get(@server.container_id)
    log = d.read_file("/haloded/sapp/sapp.log") rescue ""
    # log.gsub! /\r\n?/, "\n"
    render text: log

  end

  private

  def server_params
    params.require(:server).permit(
      :name,
      :num_players,
      :map_id,
      :time_limit,
      :mapcycle_timeout,
      :rcon_password,

      :anti_caps,
      :anti_spam,
      :friendly_fire,
      :afk_kick,
      :ping_kick,

      )
  end

end
