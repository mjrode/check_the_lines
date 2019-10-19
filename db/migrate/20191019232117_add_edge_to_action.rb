class AddEdgeToAction < ActiveRecord::Migration[6.0]
  def change
    add_column :action_games, :edge_data, :jsonb, :null => false, :default => {}
    add_index  :action_games, :edge_data, using: :gin
  end
end
