class AddTimeFieldsToWunderGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :game_time, :time
  end
end
