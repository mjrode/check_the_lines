class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :massey_games, :date, :game_date

  end
end
