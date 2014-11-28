desc "This task is called by the Heroku scheduler add-on"

task :get_new_scrape => :environment do
	puts "Fetching Games..."
	@scrape = Scrape.new
	@scrape.save
	Scrape.data_scrape(@scrape.id)
  puts "New Scrape Done."
end

task :get_last_scrape_scores => :environment do
	date = Scrape.last.created_at
	puts "Fetching Scores for Scrape #{date}..."
	Game.get_all_scores(date)
  puts "Fetch done."
end

