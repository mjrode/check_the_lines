class AddWeekToMasseyAndGameAndAction < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :week, :string
    add_column :action_games, :week, :string
    add_column :massey_games, :week, :string
  end
end
