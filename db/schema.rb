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

ActiveRecord::Schema.define(version: 20140724062011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "summons", force: true do |t|
    t.date    "service_week", null: false
    t.integer "group_number", null: false
    t.text    "phone_number", null: false
  end

  add_index "summons", ["service_week", "group_number", "phone_number"], name: "index_summons_on_service_week_and_group_number_and_phone_number", unique: true, using: :btree

end
