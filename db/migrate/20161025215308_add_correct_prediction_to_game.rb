class AddCorrectPredictionToGame < ActiveRecord::Migration
  def change
    add_column :games, :correct_prediction, :boolean
  end
end
