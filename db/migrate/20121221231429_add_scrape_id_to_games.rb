class AddScrapeIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :scrape_id, :integer
  end
end
