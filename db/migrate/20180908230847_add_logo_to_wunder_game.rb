class AddLogoToActionGame < ActiveRecord::Migration
  def change
    add_column :action_games, :home_team_logo, :text
    add_column :action_games, :away_team_logo, :text

    add_column :games, :home_team_logo, :text
    add_column :games, :away_team_logo, :text

  end
end
