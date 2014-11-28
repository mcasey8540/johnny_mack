require 'open-uri'

class Game < ActiveRecord::Base
  #validates :away, :away_predictor, :diff, :home, :home_edge, :home_predictor, :projected_spread, :spread_wagerline, :uniqueness => true

  attr_accessible :away, :away_predictor, :diff, :home, :home_edge, :home_predictor, :projected_spread, :spread_wagerline, :scrape_id, :edge
  belongs_to :scrape

  def self.get_all_scores
  	Game.all.each do |g|
  		if g.created_at.to_date > "2014-11-01".to_date 
	  		d = g.created_at
	  		home_clean = self.clean_name(g.home)
	  		away_clean = self.clean_name(g.away)
	  		begin	
	  			num = 0;
	  			ncaa_doc = Nokogiri::HTML(open("http://www.ncaa.com/game/basketball-men/d1/#{d.year}/#{d.month}/#{d.day}/#{away_clean}-#{home_clean}"))
	  			ncaa_doc.css(".score").each do |node|
	  				num == 0 ? g.awayfinal = node.content : g.homefinal = node.content 
	 				num += 1
	  			end
	  			g.save!
			rescue OpenURI::HTTPError => e
			  if e.message == '404 Not Found'
			    puts away_clean + "		" + home_clean + "		" + "http://www.ncaa.com/game/basketball-men/d1/#{d.year}/#{d.month}/#{d.day}/#{away_clean}-#{home_clean}"
			  else
			    raise e
			  end
			end
		end
	end	  		
  end

  def self.clean_name(teamname)
  	#remove spaces
  	team = teamname.gsub(/\s+/,'-')
  	#remove periods
  	team = team.gsub('.','')
  	#remove periods
  	team = team.gsub("'",'') 
  	#lowercase
  	team.downcase 	
  end

end
