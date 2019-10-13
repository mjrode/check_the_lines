class AddBestBetStrengthToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :best_bet_strength, :float
  end
end
