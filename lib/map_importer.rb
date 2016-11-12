require "json"
require "zlib"

class MapImporter
  URL = "http://halomd.macgamingmods.com/mods/mods.json.gz"

  def self.seed
    new.seed
  end

  def seed
    m = fetch_mods
    m["Mods"].each do |mod|
      map = Map.find_or_initialize_by(md5_hash: mod["hash"])
      map.name = mod["name"]
      map.description = mod["description"]
      map.human_version = mod["human_version"]
      map.identifier = mod["identifier"]
      map.patches = mod["patches"]
      map.save!
    end
  end

  private

  def fetch_mods
    io = StringIO.new(fetch_url(URL))
    JSON.parse(Zlib::GzipReader.new(io).read)
  end

  def fetch_url( url )
    page = nil
    open(url) do |f|
      page = f.read
    end
    return page
  end

end