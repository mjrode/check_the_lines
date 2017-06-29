class CreateWunderData < ActiveRecord::Migration
  def change
    create_table :wunder_games do |t|
      t.date :game_date
      t.string :sport
      t.string :home_team_name
      t.string :away_team_name
      t.integer :under_percent
      t.integer :over_percent
      t.integer :home_team_ml_percent
      t.integer :away_team_ml_percent
      t.integer :home_team_ats_percent
      t.integer :away_team_ats_percent
      t.float :away_team_vegas_line
      t.float :home_team_vegas_line
      t.float :vegas_over_under
      t.float :home_team_final_score
      t.float :away_team_final_score
      t.datetime :game_time

      t.timestamps null: false
    end
  end
end
