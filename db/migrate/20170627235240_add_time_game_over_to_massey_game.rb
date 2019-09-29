class AddTimeGameOverToMasseyGame < ActiveRecord::Migration[6.0]
  def change
    add_column :massey_games, :game_over, :boolean, default: false
  end
end
