class AddPublicBettingToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_team_money_percent, :string
    add_column :games, :away_team_money_percent, :string
    add_column :games, :home_team_spread_percent, :string
    add_column :games, :away_team_spread_percent, :string
    add_column :games, :over_percent, :string
    add_column :games, :under_percent, :string
  end
end
