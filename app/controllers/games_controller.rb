class GamesController < ApplicationController
    
	def index
    @games = Game.select(:home).uniq.order("home")
    @home_teams = @games.map {|game| game.home}
    if params[:team].nil?
      @games = []
    else
      @games = Game.where("home = :team OR away = :team", {:team => params[:team]}).order("created_at DESC")
    end
    puts params
  end 

end