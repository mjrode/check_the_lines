class AddLineDiffToGame < ActiveRecord::Migration
  def change
    add_column :games, :line_diff, :float
  end
end
