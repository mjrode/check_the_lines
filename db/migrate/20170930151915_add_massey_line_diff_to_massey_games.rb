class AddMasseyLineDiffToMasseyGames < ActiveRecord::Migration[6.0]
  def change
    add_column :massey_games, :line_diff, :float
    add_column :massey_games, :over_under_diff, :float
  end
end
