class AddAttToActionGames < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :external_id, :integer
  end
end
