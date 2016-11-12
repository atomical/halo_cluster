class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name, limit: 50
      t.string :description
      t.string :human_version
      t.string :identifier, limit: 50
      t.string :md5_hash, limit: 32
      t.text :patches


      t.timestamps null: false
    end
  end
end
