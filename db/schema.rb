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

ActiveRecord::Schema.define(version: 20170730170147) do

  create_table "products", force: :cascade do |t|
    t.string "description", null: false
    t.integer "quantity", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_editions", force: :cascade do |t|
    t.integer "race_id", null: false
    t.date "date", null: false
    t.integer "entry_fee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_race_editions_on_race_id"
  end

  create_table "race_entries", force: :cascade do |t|
    t.integer "race_edition_id", null: false
    t.integer "racer_id", null: false
    t.integer "time"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_edition_id"], name: "index_race_entries_on_race_edition_id"
    t.index ["racer_id"], name: "index_race_entries_on_racer_id"
  end

  create_table "racers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "gender", default: 0
    t.string "email", null: false
    t.string "city"
    t.string "state"
    t.date "birth_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
