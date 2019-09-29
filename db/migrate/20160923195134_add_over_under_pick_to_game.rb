class AddOverUnderPickToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :over_under_pick, :string
  end
end
