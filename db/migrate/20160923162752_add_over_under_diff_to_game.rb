class AddOverUnderDiffToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :over_under_diff, :float
  end
end
