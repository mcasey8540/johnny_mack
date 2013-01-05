class Game < ActiveRecord::Base
  validates :away, :away_predictor, :diff, :home, :home_edge, :home_predictor, :projected_spread, :spread_wagerline, :uniqueness => true
  
  attr_accessible :away, :away_predictor, :diff, :home, :home_edge, :home_predictor, :projected_spread, :spread_wagerline, :scrape_id, :edge
  belongs_to :scrape

end
