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

ActiveRecord::Schema.define(version: 20181014103231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "milestones", id: :serial, force: :cascade do |t|
    t.integer "pos"
    t.string "parkrunner"
    t.string "time"
    t.string "age_cat"
    t.string "age_grade"
    t.string "gender"
    t.string "gender_pos"
    t.string "club"
    t.string "note"
    t.integer "total"
    t.integer "run_id"
    t.integer "age_grade_position"
    t.integer "age_cat_position"
    t.string "athlete_number"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", id: :serial, force: :cascade do |t|
    t.integer "pos"
    t.string "parkrunner"
    t.integer "time"
    t.string "age_cat"
    t.string "age_grade"
    t.string "gender"
    t.string "gender_pos"
    t.string "club"
    t.string "note"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "run_id"
    t.integer "age_grade_position"
    t.integer "age_cat_position"
    t.integer "athlete_number"
    t.integer "number_in_age_category"
  end

  create_table "runs", id: :serial, force: :cascade do |t|
    t.string "run_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "metadata"
  end

  create_table "scrapes", id: :serial, force: :cascade do |t|
    t.string "nullfield"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stalkees", id: :serial, force: :cascade do |t|
    t.string "parkrunner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "athlete_number"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", id: :serial, force: :cascade do |t|
    t.text "ip_address"
    t.text "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
