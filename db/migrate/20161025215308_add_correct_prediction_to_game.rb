class AddCorrectPredictionToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :correct_prediction, :boolean
  end
end
