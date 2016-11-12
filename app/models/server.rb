class Server < ActiveRecord::Base
  RUN_STATUS = { offline: 0, online: 1, building: 2, removing: 3, failed: 4, running: 5}

  belongs_to :map
  belongs_to :user

  validates :num_players, :user, :status, presence: true
  validates :name, length: { maximum: 63 - Settings.server_name_prefix.length},
    format: { with: /\A[-a-zA-Z ]+\z/, multiline: true}, presence: true
  validates :map_id, inclusion: { in:  Proc.new{ Map.all.map(&:id)} },
    presence: true
  validates :motd, length: { maximum: 2000 }
  validates :num_players, numericality: { greater_than_or_equal_to: 1,
    less_than_or_equal_to: 16 }
  validates :rcon_password, length: { minimum: 4, maximum: 6 }, format:
    { with: /\A[-a-z]+\z/}
  validates :time_limit, inclusion: { in: 10..400 }, presence: true
  validates :mapcycle_timeout, inclusion: { in: 5..10 }
  validates :status, inclusion: { in: Proc.new{ RUN_STATUS.values } }

  before_validation :set_server_status, on: :create

  def set_defaults
    self.time_limit = 20
    self.mapcycle_timeout = 5
    self.num_players = 16
    self.afk_kick = 1200
    self.ping_kick = 750

    self.friendly_fire = true
    self.anti_spam = true
    self.anti_caps = true
  end

  def status_formatted
    case status
    when 0
      "Offline"
    when 1
      "Online"
    when 2
      "Building"
    when 3
      "Removing"
    when 4
      "Failing to build"
    when 5
      "Running"
    end
  end

  private

  def set_server_status
    self.status = RUN_STATUS[:offline]
  end

end
