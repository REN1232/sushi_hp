Rails.application.routes.draw do
	root to: "home#top"
	get "about" => "home#about"
	get "home" => "home#home"
	get "stores" => "stores#index"
	resources :notices, only: [:index,:show]
	resources :reservations, only: [:show,:create,:new]
	get "/reservations/confirm" => "reservations#confirm"

  	devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :admin do
	  resources :notices, only: [:index,:create,:edit,:update,:destroy,:new]
	  resources :reservations
	  get "about"  => "home#about"
	end
end
