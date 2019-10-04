class CreatePredGame < ActiveRecord::Migration[6.0]
  def change
    create_table :pred_games do |t|
      t.string :external_id
      t.string :home_team
      t.string :away_team
      t.float :average_home_predicted_line
      t.float :median_home_predicted_line
      t.float :standard_deviation_of_pred
      t.float :probability_home_wins
      t.float :probability_home_covers
      t.date :date
    end
  end
end
