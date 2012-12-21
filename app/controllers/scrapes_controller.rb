class ScrapesController < ApplicationController
  def index
  	@scrapes = Scrape.all
  end

  def show
  end

  def new
  	@scrape = Scrape.new
  	Scrape.data_scrape
  	@scrape.save
  	redirect_to root_path
  end

  def delete
  end

end
