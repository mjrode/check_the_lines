class AddTimeGameOverToMasseyGame < ActiveRecord::Migration
  def change
    add_column :massey_games, :game_over, :boolean, default: false
  end
end
