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

ActiveRecord::Schema.define(version: 2019_09_29_215124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_games", id: :serial, force: :cascade do |t|
    t.date "game_date"
    t.string "sport"
    t.string "home_team_name"
    t.string "away_team_name"
    t.integer "under_percent"
    t.integer "over_percent"
    t.integer "home_team_ml_percent"
    t.integer "away_team_ml_percent"
    t.integer "home_team_ats_percent"
    t.integer "away_team_ats_percent"
    t.float "away_team_vegas_line"
    t.float "home_team_vegas_line"
    t.float "vegas_over_under"
    t.float "home_team_final_score"
    t.float "away_team_final_score"
    t.datetime "game_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "external_id"
    t.boolean "processed", default: false
    t.boolean "game_over"
    t.integer "num_bets"
    t.float "home_contrarian"
    t.float "away_contrarian"
    t.float "away_steam"
    t.float "home_steam"
    t.float "home_overall_rating"
    t.float "away_overall_rating"
    t.float "home_rlm"
    t.float "away_rlm"
    t.text "home_team_logo"
    t.text "away_team_logo"
    t.text "home_team_abbr"
    t.text "away_team_abbr"
    t.datetime "start_time"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.string "sport"
    t.string "home_team_name"
    t.string "away_team_name"
    t.date "date"
    t.float "home_team_massey_line"
    t.float "away_team_massey_line"
    t.float "home_team_vegas_line"
    t.float "away_team_vegas_line"
    t.float "vegas_over_under"
    t.boolean "best_bet"
    t.boolean "processed", default: false
    t.float "massey_over_under"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "line_diff"
    t.float "over_under_diff"
    t.string "team_to_bet"
    t.string "over_under_pick"
    t.integer "home_team_final_score"
    t.integer "away_team_final_score"
    t.string "home_team_money_percent"
    t.string "away_team_money_percent"
    t.string "home_team_spread_percent"
    t.string "away_team_spread_percent"
    t.string "over_percent"
    t.string "under_percent"
    t.integer "public_percentage_on_massey_team"
    t.boolean "game_over"
    t.boolean "correct_prediction"
    t.boolean "correct_over_under_prediction"
    t.integer "public_percentage_massey_over_under"
    t.float "strength"
    t.boolean "ou_best_bet"
    t.string "time"
    t.float "home_contrarian"
    t.float "away_contrarian"
    t.float "home_steam"
    t.float "away_steam"
    t.float "home_overall_rating"
    t.float "away_overall_rating"
    t.float "home_rlm"
    t.float "away_rlm"
    t.text "home_team_logo"
    t.text "away_team_logo"
    t.text "home_team_abbr"
    t.text "away_team_abbr"
    t.string "massey_favors_home_or_away"
    t.boolean "in_progress"
  end

  create_table "massey_games", id: :serial, force: :cascade do |t|
    t.float "home_team_massey_line"
    t.float "away_team_massey_line"
    t.string "away_team_name"
    t.string "home_team_name"
    t.float "massey_over_under"
    t.float "home_team_vegas_line"
    t.float "away_team_vegas_line"
    t.float "home_team_final_score"
    t.float "away_team_final_score"
    t.date "game_date"
    t.integer "external_id"
    t.string "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "processed", default: false
    t.boolean "game_over", default: false
    t.string "time"
    t.float "line_diff"
    t.float "over_under_diff"
    t.string "team_to_bet"
  end

end
