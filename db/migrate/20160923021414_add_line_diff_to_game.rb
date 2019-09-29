class AddLineDiffToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :line_diff, :float
  end
end
