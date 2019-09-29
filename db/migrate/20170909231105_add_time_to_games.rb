class AddTimeToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :time, :string
    add_column :massey_games, :time, :string
  end
end
