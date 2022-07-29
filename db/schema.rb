# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_28_181244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "product_images", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "url", null: false
    t.string "alt_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

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
    t.string "slug"
    t.datetime "default_start_time_male"
    t.datetime "default_start_time_female"
    t.index ["race_id", "date"], name: "index_race_editions_on_race_id_and_date", unique: true
    t.index ["race_id"], name: "index_race_editions_on_race_id"
    t.index ["slug"], name: "index_race_editions_on_slug", unique: true
  end

  create_table "race_entries", force: :cascade do |t|
    t.integer "race_edition_id", null: false
    t.integer "racer_id", null: false
    t.integer "time"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bib_number"
    t.datetime "scheduled_start_time"
    t.integer "predicted_time"
    t.index ["race_edition_id"], name: "index_race_entries_on_race_edition_id"
    t.index ["racer_id"], name: "index_race_entries_on_racer_id"
  end

  create_table "racers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "gender"
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
    t.string "slug"
    t.string "short_name"
    t.index ["name"], name: "index_races_on_name", unique: true
    t.index ["slug"], name: "index_races_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "product_images", "products"
  add_foreign_key "race_editions", "races"
  add_foreign_key "race_entries", "race_editions"
  add_foreign_key "race_entries", "racers"
end
