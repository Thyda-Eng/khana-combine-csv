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

ActiveRecord::Schema.define(version: 20180209031722) do

  create_table "reports", force: :cascade do |t|
    t.string   "phone_number",       limit: 255
    t.integer  "week",               limit: 4
    t.integer  "index",              limit: 4
    t.integer  "connector_a",        limit: 4
    t.integer  "connector_b",        limit: 4
    t.integer  "connector_c",        limit: 4
    t.integer  "total_sent_sms",     limit: 4
    t.integer  "total_received_sms", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
