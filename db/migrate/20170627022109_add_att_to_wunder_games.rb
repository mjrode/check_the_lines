class AddAttToWunderGames < ActiveRecord::Migration
  def change
    add_column :wunder_games, :external_id, :integer
  end
end
