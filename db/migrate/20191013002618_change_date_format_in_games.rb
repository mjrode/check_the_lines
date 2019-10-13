class ChangeDateFormatInGames < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :date, :datetime
  end
end
