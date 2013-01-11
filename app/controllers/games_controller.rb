class GamesController < ApplicationController
    
	def index
    @games = Game.select(:home).uniq.order("home")
    @home_teams = @games.map {|game| game.home}
    if params[:team].nil?
      @games = []
    else
      @games = Game.where("home = :team OR away = :team", {:team => params[:team]}).order("created_at DESC")
      @games.map!{|t|	
      [
      t.created_at.to_date,
			t.away,
			t.away_predictor,
			t.home,
			t.home_predictor,
			t.home_edge,
			t.projected_spread,
			t.spread_wagerline,
			t.diff,
			t.edge]
			}.uniq!
    end
  end 

end