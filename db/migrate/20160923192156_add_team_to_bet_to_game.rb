class AddTeamToBetToGame < ActiveRecord::Migration
  def change
    add_column :games, :team_to_bet, :string
  end
end
