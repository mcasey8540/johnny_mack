class ScrapesController < ApplicationController
  def index
  	@scrapes = Scrape.all
  end

  def show
  	@scrape = Scrape.find(params[:id])
  	@games  = @scrape.games
  end

  def new
  	@scrape = Scrape.new
  	@scrape.save
  	Scrape.data_scrape(@scrape.id)
  	redirect_to root_path
  end

  def delete
  end

end
