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

ActiveRecord::Schema.define(:version => 20111209020724) do

  create_table "examples", :force => true do |t|
    t.integer  "birth_year"
    t.integer  "birth_month"
    t.integer  "birth_day"
    t.integer  "birth_dow"
    t.integer  "favorite_season"
    t.float    "latitude"
    t.float    "miles_from_major_city"
    t.float    "time_outdoors"
    t.integer  "gender"
    t.integer  "preferred_pattern"
    t.integer  "likes_spicy_food"
    t.integer  "dominant_hand"
    t.integer  "prefers_baths"
    t.integer  "preferred_pet"
    t.integer  "night_or_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
    t.integer  "favorite_color"
  end

  create_table "surveys", :force => true do |t|
    t.date     "birthday"
    t.string   "favorite_season"
    t.string   "hometown"
    t.integer  "time_outdoors"
    t.string   "gender"
    t.integer  "preferred_pattern"
    t.boolean  "likes_spicy_food"
    t.string   "dominant_hand"
    t.boolean  "prefers_baths"
    t.string   "preferred_pet"
    t.string   "night_or_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "favorite_color"
  end

end
