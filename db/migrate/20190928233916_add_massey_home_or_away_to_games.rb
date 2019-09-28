class AddMasseyHomeOrAwayToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :massey_favors_home_or_away, :string
  end
end
