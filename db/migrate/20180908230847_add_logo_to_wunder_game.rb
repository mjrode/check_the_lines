class AddLogoToWunderGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :home_team_logo, :text
    add_column :wunder_games, :away_team_logo, :text
    
    add_column :games, :home_team_logo, :text
    add_column :games, :away_team_logo, :text

  end
end
