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

ActiveRecord::Schema.define(version: 20150505214921) do

  create_table "events", force: :cascade do |t|
    t.integer  "organizer_id"
    t.string   "description",                        null: false
    t.datetime "starting_date_time",                 null: false
    t.boolean  "is_all_day",         default: false
    t.text     "notes"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "ending_date_time"
  end

  add_index "events", ["organizer_id"], name: "index_events_on_organizer_id"
  add_index "events", ["starting_date_time"], name: "index_events_on_starting_date_time"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin",        default: false
    t.datetime "activation_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
