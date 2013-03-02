CloneBrew::Application.routes.draw do

  resources :mash_steps


  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions'
  }

  resources :ingredient_details
  resources :ingredient_categories
  resources :ingredients
  resources :recipes
  resources :beers
  resources :breweries

  get "brewery_db/search"
  get "home/index"

  root :to => 'home#index'
end
