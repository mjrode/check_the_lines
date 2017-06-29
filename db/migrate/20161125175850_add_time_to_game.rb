class AddTimeToGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :game_time, :time
    add_column :massey_games, :game_time, :time
  end
end
