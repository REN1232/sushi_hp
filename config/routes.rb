Rails.application.routes.draw do
	root to: "home#top"
	get "about" => "home#about"
	get "shop" => "home#shop"
	get "store" => "home#store"
	get "menus" => "home#menus"
	resources :notices, only: [:index,:show]
	resources :reservations, only: [:show,:create,:new]
	get "/reservations/confirm" => "reservations#confirm"

  	devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :admin do
	  resources :notices, only: [:index,:create,:edit,:update,:destroy,:new]
	  resources :reservations
	  root to: "home#about"
	end
end
