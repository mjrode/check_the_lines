class AddOverUnderPickToGame < ActiveRecord::Migration
  def change
    add_column :games, :over_under_pick, :string
  end
end
