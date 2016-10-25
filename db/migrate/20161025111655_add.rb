class Add < ActiveRecord::Migration
  def change
    add_column :games, :game_over, :boolean, deafult: false
  end
end
