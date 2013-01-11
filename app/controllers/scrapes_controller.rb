class ScrapesController < ApplicationController
  def index
    if params[:start_date].nil?
  	  @scrapes = Scrape.order("created_at DESC")
    else
      @scrapes = Scrape.where("created_at between :start_date and :end_date", {:start_date => params[:start_date], :end_date => params[:end_date]}).order("created_at DESC")
    end
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
