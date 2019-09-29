class AddOverUnderPredictionToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :correct_over_under_prediction, :boolean
  end
end
