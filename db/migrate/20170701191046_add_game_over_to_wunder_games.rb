class AddGameOverToWunderGames < ActiveRecord::Migration
  def change
    add_column :wunder_games, :game_over, :boolean
  end
end
