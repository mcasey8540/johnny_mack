JohnnyMack::Application.routes.draw do

  resources :scrapes do
  	resources :games 
  end

  root to: "scrapes#index" 

  match 'scrapes/new' => "scrapes#new"

  match "scrapes/:id" => "scrapes#show"

  match 'scrapes/:id/delete' => 'scrapes#delete', :as => :delete_scrape

  match 'games' => 'games#index', :as => :games

end
