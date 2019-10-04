class AddSportToPredGames < ActiveRecord::Migration[6.0]
  def change
    add_column :pred_games, :sport, :string
  end
end
