class AddAttToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_team_vegas_line_massey, :float
    add_column :games, :away_team_vegas_line_massey, :float
  end
end
