class ChangeStrengthName < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :strength, :home_team_strength
    add_column :games, :away_team_strength, :float
  end
end
