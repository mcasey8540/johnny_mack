class AddHomefinalToGames < ActiveRecord::Migration
  def change
    add_column :games, :homefinal, :float
  end
end
