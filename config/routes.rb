JohnnyMack::Application.routes.draw do

  resources :scrapes

  root to: "scrapes#index" 

  match 'scrapes/new' => "scrapes#new"

end
