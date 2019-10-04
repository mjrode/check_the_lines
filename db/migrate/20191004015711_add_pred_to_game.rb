class AddPredToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :average_home_predicted_line, :float
    add_column :games, :median_home_predicted_line, :float
    add_column :games, :standard_deviation_of_pred, :float
    add_column :games, :probability_home_wins, :float
    add_column :games, :probability_home_covers, :float
  end
end
