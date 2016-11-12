class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name, limit: 63
      t.integer :map_id
      t.integer :user_id
      t.integer :status
      t.integer :num_players
      t.string :rcon_password, limit: 6
      t.text :motd, limit: 2000
      t.integer :port
      t.string :container_id

      t.integer :time_limit
      t.integer :mapcycle_timeout
      t.integer :afk_kick
      t.integer :ping_kick
      t.integer :spawn_protection
      t.boolean :save_scores
      t.boolean :friendly_fire
      t.boolean :anti_caps
      t.boolean :anti_spam

      t.datetime :deleted_at, index: true

      t.timestamps null: false
    end
  end
end
