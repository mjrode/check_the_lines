class AddFieldsToActionGame < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :processed, :boolean, default: false
    add_column :massey_games, :processed, :boolean, default: false
  end
end
