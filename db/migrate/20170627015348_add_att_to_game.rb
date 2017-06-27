class AddAttToGame < ActiveRecord::Migration
  def change
    add_column :games, :home_team_vegas_line_wunder, :float
    add_column :games, :away_team_vegas_line_wunder, :float
  end
end
