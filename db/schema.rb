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

ActiveRecord::Schema.define(:version => 20141128173059) do

  create_table "games", :force => true do |t|
    t.string   "away"
    t.float    "away_predictor"
    t.string   "home"
    t.float    "home_predictor"
    t.float    "home_edge"
    t.float    "projected_spread"
    t.float    "spread_wagerline"
    t.float    "diff"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "scrape_id"
    t.string   "edge"
    t.float    "homefinal"
    t.float    "awayfinal"
  end

  create_table "scrapes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
