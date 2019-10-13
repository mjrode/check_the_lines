class AddExternalIdToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :external_id, :integer, unique: true
  end
end
