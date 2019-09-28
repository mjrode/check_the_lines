class AddAttToActionGames < ActiveRecord::Migration
  def change
    add_column :action_games, :external_id, :integer
  end
end
