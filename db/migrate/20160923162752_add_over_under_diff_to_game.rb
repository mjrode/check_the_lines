class AddOverUnderDiffToGame < ActiveRecord::Migration
  def change
    add_column :games, :over_under_diff, :float
  end
end
