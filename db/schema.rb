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

ActiveRecord::Schema.define(version: 20180306220614) do

  create_table "locations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "weather_id"
    t.string  "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

  create_table "weathers", force: :cascade do |t|
    t.string  "temperature"
    t.string  "min_temperature"
    t.string  "max_temperature"
    t.string  "wind_speed"
    t.integer "humidity"
    t.string  "condition"
  end

end
