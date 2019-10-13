class AddStartTimeToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :start_time, :datetime
  end
end
