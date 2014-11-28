JohnnyMack::Application.routes.draw do

  resources :scrapes do
  	resources :games 
  end

  root to: "scrapes#index" 

  match 'scrapes/new' => "scrapes#new"

  match "scrapes/:id" => "scrapes#show"

  match 'scrapes/:id/delete' => 'scrapes#delete', :as => :delete_scrape

  match 'games/get_all_scores' => 'games#get_all_scores', :as => :get_all_scores

  match 'scrapes/:id/get_scores' => 'scrapes#get_scores', :as => :get_scores

  match 'games' => 'games#index', :as => :games

end
