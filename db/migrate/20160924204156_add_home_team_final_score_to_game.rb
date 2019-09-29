class AddHomeTeamFinalScoreToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :home_team_final_score, :integer
    add_column :games, :away_team_final_score, :integer
  end
end
