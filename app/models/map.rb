class Map < ActiveRecord::Base
  has_many :servers

  serialize :patches

  validates :name, :identifier, :hash, :human_version, :description,
    :md5_hash, presence: true
  validates :md5_hash, uniqueness: true

  def map_file_present?
    File.exist?(map_file_path)
  end

  def map_file_path
    File.join(Settings.maps_path, identifier)
  end

  def download
    return if map_file_present?
    url = URI.join(Settings.map_server_path, "#{identifier}.zip").to_s
    zip_file = nil
    open(url) do |f|
      zip_file = f.read
    end

  end
end
