class AddMasseyPublicToGames < ActiveRecord::Migration
  def change
    add_column :games, :public_percentage_on_massey_team, :integer
  end
end
