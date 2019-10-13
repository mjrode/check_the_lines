class AddAbbrToActionGame < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :home_team_abbr, :text
    add_column :action_games, :away_team_abbr, :text

    add_column :games, :home_team_abbr, :text
    add_column :games, :away_team_abbr, :text

  end
end
