class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :game_over, :boolean, deafult: false
  end
end
