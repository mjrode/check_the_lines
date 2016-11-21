class AddStrengthToGame < ActiveRecord::Migration
  def change
    add_column :games, :strength, :decimal
  end
end
