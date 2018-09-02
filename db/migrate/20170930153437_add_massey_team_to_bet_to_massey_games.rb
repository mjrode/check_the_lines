class AddMasseyTeamToBetToMasseyGames < ActiveRecord::Migration
  def change
    add_column :massey_games, :team_to_bet, :string
  end
end
