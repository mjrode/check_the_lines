class AddEdgeToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :edge_data, :jsonb, :null => false, :default => {}
    add_index  :games, :edge_data, using: :gin
  end
end
