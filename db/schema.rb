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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140305170000) do

  create_table "events", :force => true do |t|
    t.integer  "indicator_id"
    t.integer  "status_id"
    t.text     "message"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "started_at"
  end

  create_table "indicators", :force => true do |t|
    t.integer "service_id"
    t.integer "project_id"
    t.string  "custom_url"
  end

  add_index "indicators", ["project_id", "service_id"], :name => "index_indicators_on_project_id_and_service_id", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "services", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "statuses", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "api_key"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
