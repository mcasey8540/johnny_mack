class AddAwayfinalToGames < ActiveRecord::Migration
  def change
    add_column :games, :awayfinal, :float
  end
end
