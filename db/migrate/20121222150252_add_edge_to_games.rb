class AddEdgeToGames < ActiveRecord::Migration
  def change
    add_column :games, :edge, :string
  end
end
