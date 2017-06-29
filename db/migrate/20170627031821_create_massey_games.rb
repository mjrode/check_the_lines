class CreateMasseyGames < ActiveRecord::Migration
  def change
    create_table :massey_games do |t|
      t.float :home_team_massey_line
      t.float :away_team_massey_line
      t.string :away_team_name
      t.string :home_team_name
      t.float :massey_over_under
      t.float :home_team_vegas_line
      t.float :away_team_vegas_line
      t.float :home_team_final_score
      t.float :away_team_final_score
      t.date :date
      t.integer :external_id
      t.string :sport

      t.timestamps null: false
    end
  end
end
