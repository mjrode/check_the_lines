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

ActiveRecord::Schema.define(version: 20161026145322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "sport"
    t.string   "home_team_name"
    t.string   "away_team_name"
    t.date     "date"
    t.float    "home_team_massey_line"
    t.float    "away_team_massey_line"
    t.float    "home_team_vegas_line"
    t.float    "away_team_vegas_line"
    t.float    "vegas_over_under"
    t.float    "massey_over_under"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "line_diff"
    t.float    "over_under_diff"
    t.string   "team_to_bet"
    t.string   "over_under_pick"
    t.integer  "home_team_final_score"
    t.integer  "away_team_final_score"
    t.integer  "week_id"
    t.string   "home_team_money_percent"
    t.string   "away_team_money_percent"
    t.string   "home_team_spread_percent"
    t.string   "away_team_spread_percent"
    t.string   "over_percent"
    t.string   "under_percent"
    t.integer  "public_percentage_on_massey_team"
    t.boolean  "game_over"
    t.boolean  "correct_prediction"
    t.boolean  "correct_over_under_prediction"
    t.integer  "public_percentage_massey_over_under"
  end

end
