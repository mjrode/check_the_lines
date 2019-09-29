class AddOuBestBetToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :ou_best_bet, :boolean
  end
end
