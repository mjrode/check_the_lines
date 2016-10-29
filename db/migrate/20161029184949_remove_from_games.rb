class RemoveFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :home_team_money_percent
    remove_column :games, :away_team_money_percent
  end
end
