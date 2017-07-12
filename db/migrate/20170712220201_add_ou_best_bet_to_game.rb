class AddOuBestBetToGame < ActiveRecord::Migration
  def change
    add_column :games, :ou_best_bet, :boolean
  end
end
