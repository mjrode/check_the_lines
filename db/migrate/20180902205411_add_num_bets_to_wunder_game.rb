class AddNumBetsToActionGame < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :num_bets, :integer
  end
end
