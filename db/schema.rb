# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161015134332) do

  create_table "maps", force: :cascade do |t|
    t.string   "name",          limit: 50
    t.string   "description"
    t.string   "human_version"
    t.string   "identifier",    limit: 50
    t.string   "md5_hash",      limit: 32
    t.text     "patches"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string   "name",             limit: 63
    t.integer  "map_id"
    t.integer  "user_id"
    t.integer  "status"
    t.integer  "num_players"
    t.string   "rcon_password",    limit: 6
    t.text     "motd",             limit: 2000
    t.integer  "port"
    t.string   "container_id"
    t.integer  "time_limit"
    t.integer  "mapcycle_timeout"
    t.integer  "afk_kick"
    t.integer  "ping_kick"
    t.integer  "spawn_protection"
    t.boolean  "save_scores"
    t.boolean  "friendly_fire"
    t.boolean  "anti_caps"
    t.boolean  "anti_spam"
    t.datetime "deleted_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "servers", ["deleted_at"], name: "index_servers_on_deleted_at"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
