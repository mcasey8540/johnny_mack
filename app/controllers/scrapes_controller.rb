class ScrapesController < ApplicationController
  def index
  	@scrapes = Scrape.order("created_at DESC")
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
  	Scrape.destroy(params[:id])
  	redirect_to root_path
  end

end
