class AddStrengthToGame < ActiveRecord::Migration
  def change
    add_column :games, :strength, :float
  end
end
