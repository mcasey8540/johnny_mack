require 'open-uri'

class Scrape < ActiveRecord::Base
  has_many :games

  def self.data_scrape(id)
  	puts "------------#{id}"
  	@scrape = Scrape.find(id)

	  cover_doc = Nokogiri::HTML(open('http://www.covers.com/odds/basketball/college-basketball-odds.aspx'))
		usa_doc   = Nokogiri::HTML(open('http://usatoday30.usatoday.com/sports/sagarin/bkt1213.htm'))

		#Covers Doc

		games = []

		cover_doc.css('.team_away strong','.team_home strong','div.covers_bottom').each do |node|
			games << node.content.strip.gsub(/@/,"")
		end 

		n = games.size/3

		start_away = 0 t
		start_home = n
		start_cover = n*2 

		covers_data = []

		n.times do |i|
			covers_data << Hash["away_team",games[start_away],"home_team", games[start_home],"cover", games[start_cover]]
			start_home += 1
			start_away += 1
			start_cover += 1
		end

		# CSV.open('covers.csv', 'w+') do |csv|
		# 	covers_data.each do |hash|
		# 		csv << [hash["away_team"], hash["home_team"], hash["cover"]]
		# 	end
		# end

		#USA Today Doc

		t = []

		usa_doc.xpath('//pre').each do |node|
			t << node.text
		end

		v1 = t[1].split(/\n/)

		v1[4].split("[")[3].split("]")[0].strip

		team_groups = []
		teams = []
		team_data = []
		reconciled_data = []

		start = 5
		last = 14

		35.times do |i|
			team_groups << v1[start..last]
			start = last+4
			last  = start+9
		end


		team_groups.each do |group|
			group.each do |team_info|
				teams << team_info
			end
		end

		teams.pop

		teams.each do |info|
			team_data << Hash["team_name", info.split("=")[0].gsub(/\d/,"").strip, "predictor", info.split("=")[1].split("|")[3].split(" ")[0].strip ]
		end

		team_data.map! do |td|
			if td['team_name'] == 'Albany-NY' then Hash['team_name','Albany', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Binghamton-NY' then Hash['team_name','Binghamton', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Boston U.' then Hash['team_name','Boston U', 'predictor', td['predictor']]
				elsif td['team_name'] == 'UMBC' then Hash['team_name','MD Baltimore Cty', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Stony Brook-NY' then Hash['team_name','Stony Brook', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Florida State' then Hash['team_name','Florida St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC State' then Hash['team_name','N.C. State', 'predictor', td['predictor']]
				elsif td['team_name'] == 'East Tennessee State' then Hash['team_name','East Tennessee St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Kennesaw State' then Hash['team_name','Kennesaw St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'North Florida(UNF)' then Hash['team_name','North Florida', 'predictor', td['predictor']]
				elsif td['team_name'] == 'USC Upstate' then Hash['team_name','South Carolina Upstate', 'predictor', td['predictor']]
				elsif td['team_name'] == "Saint Joseph's-Pa" then Hash['team_name',"St. Joseph's", 'predictor', td['predictor']]
				elsif td['team_name'] == 'VCU(Va. Commonwealth)' then Hash['team_name','VCU', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Xavier-Ohio' then Hash['team_name','Xavier', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Weber State' then Hash['team_name','Weber St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Portland State' then Hash['team_name','Portland St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Montana State' then Hash['team_name','Montana St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC Asheville' then Hash['team_name','N.C. Asheville', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Presbyterian College' then Hash['team_name','Presbyterian', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Ohio State' then Hash['team_name','Ohio St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Michigan State' then Hash['team_name','Michigan St', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Penn State' then Hash['team_name','Penn St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Oklahoma State' then Hash['team_name','Oklahoma St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Kansas State' then Hash['team_name','Kansas St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'TCU' then Hash['team_name','Texas Christian', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Iowa State' then Hash['team_name','Iowa St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Cal Poly-SLO' then Hash['team_name','Cal Poly SLO', 'predictor', td['predictor']]
				elsif td['team_name'] == 'CS Fullerton' then Hash['team_name','Cal St. Fullerton', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Long Beach State' then Hash['team_name','Long Beach St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'CS Northridge' then Hash['team_name','CSU Northridge', 'predictor', td['predictor']]
				elsif td['team_name'] == "Hawai'i" then Hash['team_name','Hawaii', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Georgia State' then Hash['team_name','Georgia St', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC Wilmington' then Hash['team_name','NC-Wilmington', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Central Florida(UCF)' then Hash['team_name','Central Florida', 'predictor', td['predictor']]
				elsif td['team_name'] == 'SMU' then Hash['team_name','Southern Methodist', 'predictor', td['predictor']]
				elsif td['team_name'] == 'UTEP' then Hash['team_name','Texas-El Paso', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Chicago State' then Hash['team_name','Chicago St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NJIT(New Jersey Tech)' then Hash['team_name','New Jersey Tech', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Youngstown State' then Hash['team_name','Youngstown St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Cleveland State' then Hash['team_name','Cleveland St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Wright State' then Hash['team_name','Wright St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Milwaukee' then Hash['team_name','Wis.-Milwaukee', 'predictor', td['predictor']]
				elsif td['team_name'] == 'CS Bakersfield' then Hash['team_name','Cal. State - Bakersfield', 'predictor', td['predictor']]
				elsif td['team_name'] == "Saint Peter's" then Hash['team_name',"St. Peter's", 'predictor', td['predictor']]
				elsif td['team_name'] == 'Miami-Ohio' then Hash['team_name','Miami (OH)', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Kent State' then Hash['team_name','Kent St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Ball State' then Hash['team_name','Ball St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Coppin State' then Hash['team_name','Coppin St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Md.-Eastern Shore(UMES)' then Hash['team_name','Maryland - E. Shore', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Morgan State' then Hash['team_name','Morgan St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC A&T' then Hash['team_name','No.Carolina A&T', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC Central' then Hash['team_name','North Carolina Central', 'predictor', td['predictor']]
				elsif td['team_name'] == 'SC State' then Hash['team_name','South Carolina State', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Wichita State' then Hash['team_name','Wichita St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Illinois State' then Hash['team_name','Illinois St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Indiana State' then Hash['team_name','Indiana St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Missouri State' then Hash['team_name','Missouri St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'San Diego State' then Hash['team_name','San Diego St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Colorado State' then Hash['team_name','Colorado St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Boise State' then Hash['team_name','Boise St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Fresno State' then Hash['team_name','Fresno St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Long Island U.' then Hash['team_name','LIU Brooklyn', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Central Connecticut St.' then Hash['team_name','Central Conn. St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Saint Francis-NY' then Hash['team_name','St. Francis (NY)', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Saint Francis-PA' then Hash['team_name','St. Francis (PA)', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Murray State' then Hash['team_name','Murray St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'SE Missouri State(SEMO)' then Hash['team_name','SE Missouri St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Morehead State' then Hash['team_name','Morehead St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Tennessee State' then Hash['team_name','Tennessee St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Jacksonville State' then Hash['team_name','Jacksonville St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'SIU-Edwardsville' then Hash['team_name','SIU - Edwardsville', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Tennessee Martin' then Hash['team_name','Tenn-Martin', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Arizona State' then Hash['team_name','Arizona St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Oregon State' then Hash['team_name','Oregon St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Washington State' then Hash['team_name','Washington State', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Mississippi State' then Hash['team_name','Mississippi St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'LSU' then Hash['team_name','Louisiana State', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Appalachian State' then Hash['team_name','Appalachian St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Elon' then Hash['team_name','Elon University', 'predictor', td['predictor']]
				elsif td['team_name'] == 'NC Greensboro' then Hash['team_name','NC-Greensboro', 'predictor', td['predictor']]
				elsif td['team_name'] == 'The Citadel' then Hash['team_name','Citadel', 'predictor', td['predictor']]
				elsif td['team_name'] == 'College of Charleston' then Hash['team_name','Charleston', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Northwestern State' then Hash['team_name','Northwestern St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'McNeese State' then Hash['team_name','McNeese St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Sam Houston State' then Hash['team_name','Sam Houston St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'SE Louisiana' then Hash['team_name','Southeastern Louisiana', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Nicholls State' then Hash['team_name','Nicholls St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Texas A&M-CorpusChristi' then Hash['team_name','Texas A&M CC', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Southern U.' then Hash['team_name','Southern', 'predictor', td['predictor']]
				elsif td['team_name'] == 'MVSU(Miss. Valley St.)' then Hash['team_name','Mississippi Valley State', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Alcorn State' then Hash['team_name','Alcorn St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Ark.-Pine Bluff' then Hash['team_name','Arkansas-Pine Bluff', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Alabam State' then Hash['team_name','Alabama St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'IUPUI' then Hash['team_name','Indiana Purdue', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Fort Wayne(IPFW)' then Hash['team_name','IUPU - Ft. Wayne', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Omaha(Neb.-Omaha)' then Hash['team_name','Nebraska Omaha', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Oakland-Mich.' then Hash['team_name','Oakland', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Kansas City(UMKC)' then Hash['team_name','UMKC', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Fla. International' then Hash['team_name','Florida International', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Middle Tennessee' then Hash['team_name','Middle Tennessee St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Arkansas State' then Hash['team_name','Arkansas St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Ark.-Little Rock' then Hash['team_name','Arkansas-Little Rock', 'predictor', td['predictor']]
				elsif td['team_name'] == 'BYU' then Hash['team_name','Brigham Young', 'predictor', td['predictor']]
				elsif td['team_name'] == "Saint Mary's-Cal." then Hash['team_name',"St. Mary's", 'predictor', td['predictor']]
				elsif td['team_name'] == 'New Mexico State' then Hash['team_name','New Mexico St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Utah State' then Hash['team_name','Utah St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'San Jose State' then Hash['team_name','San Jose St.', 'predictor', td['predictor']]
				elsif td['team_name'] == 'Texas-San Antonio(UTSA)' then Hash['team_name','Texas-San Antonio', 'predictor', td['predictor']]
				else 	Hash["team_name", td["team_name"], "predictor", td["predictor"]]
			end
		end

		away_predictor 		= ''
		home_predictor 		= ''
		home_edge 				= ''
		projected_spread 	= ''
		spread_covers    	= ''
		diff							= ''
		date      		 		= (Time.now).to_date

		# CSV.open('game_data.csv', 'w+') do |csv|
		# 	csv << ["Date", "Away", "Predictor", "Home", "Predictor","Home Edge", "Projected Spread", "Spread (Wagerline)", "Diff", "Edge" ]
			covers_data.each do |cd|
				team_data.each do |td|
					if 		cd["away_team"] == td["team_name"] then away_predictor = td["predictor"]
					elsif cd["home_team"] == td["team_name"] then home_predictor = td["predictor"]
					end
				end

			home_edge 			 = (home_predictor.to_f + v1[4].split("[")[3].split("]")[0].strip.to_f).round(2)
			projected_spread = (away_predictor.to_f - home_edge.to_f).round(2)
			spread_covers    = cd["cover"].to_f.round(2)
			diff 						 = (spread_covers.abs - projected_spread.abs).abs.round(2)
			edge 						 = spread_covers > projected_spread ? cd["home_team"] : cd["away_team"]


			# csv << [date, cd["away_team"], away_predictor, cd["home_team"], home_predictor, home_edge, projected_spread, spread_covers, diff, edge ]
				@game = @scrape.games.new( :away => cd["away_team"], :away_predictor => away_predictor, :home => cd["home_team"], :home_predictor => home_predictor, :home_edge => home_edge, :projected_spread => projected_spread, :spread_wagerline => spread_covers, :diff =>  diff, :edge => edge)
				@game.save
			end
		end
end


