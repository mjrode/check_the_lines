class AddGameOverToActionGames < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :game_over, :boolean
  end
end
