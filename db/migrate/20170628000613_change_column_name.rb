class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :massey_games, :date, :game_date

  end
end
