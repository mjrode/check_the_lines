class AddFieldsToWunderGame < ActiveRecord::Migration
  def change
    add_column :wunder_games, :processed, :boolean, default: false
    add_column :massey_games, :processed, :boolean, default: false
  end
end
