class AddOverUnderPredictionToGame < ActiveRecord::Migration
  def change
    add_column :games, :correct_over_under_prediction, :boolean
  end
end
