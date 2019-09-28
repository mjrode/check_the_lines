class AddNumBetsToActionGame < ActiveRecord::Migration
  def change
    add_column :action_games, :num_bets, :integer
  end
end
