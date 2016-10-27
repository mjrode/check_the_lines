class AddPublicPercentageMasseyOverUnderToGame < ActiveRecord::Migration
  def change
    add_column :games, :public_percentage_massey_over_under, :integer
  end
end
