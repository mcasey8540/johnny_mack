desc "This task is called by the Heroku scheduler add-on"

task :get_new_scrape => :environment do
	puts "Fetching Games..."
	@scrape = Scrape.new
	@scrape.save
	Scrape.data_scrape(@scrape.id)
  puts "New Scrape Done."
end

task :get_last_scrape_scores => :environment do
	@scrape = Scrape.last
	puts "Fetching Scores for Scrape #{@scrape.created_at}..."
	@scrape.get_scores
  puts "Fetch done."
end

