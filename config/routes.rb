Rails.application.routes.draw do
  get 'sessions/new'

	resources :tweets, :users, :sessions

	root to: "tweets#index"
	get '/all' => redirect('/tweets')
	get '/local_tweets/:zipcode' => 'tweets#index'
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "make" => "tweets#new", :as => "make"
  get '/tweets/:id/destroy' => "tweets#destroy", :as => "clear"
  get '/users/:id/destroy' => "users#destroy", :as => "delete_acct"
end
