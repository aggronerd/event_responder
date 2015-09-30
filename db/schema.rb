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

ActiveRecord::Schema.define(version: 20150930200135) do

  create_table "email_types", force: :cascade do |t|
    t.string "name", limit: 128, null: false
  end

  add_index "email_types", ["name"], name: "index_email_types_on_name"

  create_table "event_types", force: :cascade do |t|
    t.string "name", limit: 128, null: false
  end

  add_index "event_types", ["name"], name: "index_event_types_on_name"

  create_table "events", id: false, force: :cascade do |t|
    t.integer  "event_type_id"
    t.integer  "email_type_id"
    t.datetime "created_at"
  end

  add_index "events", ["email_type_id"], name: "index_events_on_email_type_id"
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id"

end
