class AddMasseyTeamToBetToMasseyGames < ActiveRecord::Migration[6.0]
  def change
    add_column :massey_games, :team_to_bet, :string
  end
end
