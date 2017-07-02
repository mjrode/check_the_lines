class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :sport
      t.string :home_team_name
      t.string :away_team_name
      t.date :date
      t.float :home_team_massey_line
      t.float :away_team_massey_line
      t.float :home_team_vegas_line
      t.float :away_team_vegas_line
      t.float :vegas_over_under
      t.boolean :best_bet
      t.boolean :processed, default: false
      t.float :massey_over_under

      t.timestamps null: false
    end
  end
end
