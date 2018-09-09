class AddAbbrToWunderGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :home_team_abbr, :text
    add_column :wunder_games, :away_team_abbr, :text
    
    add_column :games, :home_team_abbr, :text
    add_column :games, :away_team_abbr, :text

  end
end
