class AddSharpReportToActionGames < ActiveRecord::Migration
  def change
    add_column :action_games, :home_contrarian, :float
    add_column :action_games, :away_contrarian, :float
    add_column :action_games, :away_steam, :float
    add_column :action_games, :home_steam, :float
    add_column :action_games, :home_overall_rating, :float
    add_column :action_games, :away_overall_rating, :float
    add_column :action_games, :home_rlm, :float
    add_column :action_games, :away_rlm, :float

    add_column :games, :home_contrarian, :float
    add_column :games, :away_contrarian, :float
    add_column :games, :home_steam, :float
    add_column :games, :away_steam, :float
    add_column :games, :home_overall_rating, :float
    add_column :games, :away_overall_rating, :float
    add_column :games, :home_rlm, :float
    add_column :games, :away_rlm, :float

  end
end
