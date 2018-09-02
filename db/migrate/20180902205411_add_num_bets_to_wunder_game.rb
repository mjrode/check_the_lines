class AddNumBetsToWunderGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :num_bets, :integer
  end
end
