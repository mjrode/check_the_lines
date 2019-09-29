class AddPublicPercentageMasseyOverUnderToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :public_percentage_massey_over_under, :integer
  end
end
