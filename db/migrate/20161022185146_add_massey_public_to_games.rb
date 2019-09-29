class AddMasseyPublicToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :public_percentage_on_massey_team, :integer
  end
end
