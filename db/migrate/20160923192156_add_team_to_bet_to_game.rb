class AddTeamToBetToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :team_to_bet, :string
  end
end
