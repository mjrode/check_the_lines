class ChangeLineDiffName < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :line_diff, :home_team_line_diff
    add_column :games, :away_team_line_diff, :float
  end
end
