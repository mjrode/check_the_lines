class AddStrengthToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :strength, :float
  end
end
