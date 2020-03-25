Rails.application.routes.draw do

	#HP側
	root to: "home#top"
	get "about" => "home#about"
	get "kodawari" => "home#kodawari"
	get "store" => "home#store"
	get "menus" => "home#menus"
	resources :notices, only: [:index,:show]
	resources :reservations, only: [:show,:create,:new,:destroy]
	post "/reservations/confirm"  => "reservations#confirm"
	post "/reservations/new"=> "reservations#back"
	get "delete"=> "reservations#delete"
	get 'ajax', to: 'reservations#ajax'

	 ##管理者側
  	devise_for :admins, skip: :all
  	#ログイン画面制限
	devise_scope :admin do
	  get 'login' => 'devise/sessions#new', as: :new_admin_session
	  post 'login' => 'devise/sessions#create', as: :admin_session
	  delete 'logout' => 'devise/sessions#destroy', as: :destroy_admin_session
	end

	# ゲストログイン用URL
	devise_scope :admin do
	    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :admin do
	  resources :notices
	  resources :reservations
	  get 'ajax', to: 'reservations#ajax'
	  root to: "home#about"
	end
end
