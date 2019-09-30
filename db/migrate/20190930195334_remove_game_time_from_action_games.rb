class RemoveGameTimeFromActionGames < ActiveRecord::Migration[6.0]
  def change

    remove_column :action_games, :game_time, :string
  end
end
