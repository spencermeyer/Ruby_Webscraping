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

ActiveRecord::Schema.define(version: 20170212101116) do

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pos"
    t.string   "parkrunner"
    t.string   "time"
    t.string   "age_cat"
    t.string   "age_grade"
    t.string   "gender"
    t.string   "gender_pos"
    t.string   "club"
    t.string   "note"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "run_id"
  end

  create_table "runs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "run_identifier"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "scrapes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nullfield"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
