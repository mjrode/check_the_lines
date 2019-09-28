class AddGameOverToActionGames < ActiveRecord::Migration
  def change
    add_column :action_games, :game_over, :boolean
  end
end
