Rails.application.routes.draw do
  get 'pages/index'

  devise_for :users
  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ForAPI
  # User
  get '/api/v1/users' => 'api/v1/users#index'

  # Screenshot
  post '/api/v1/screenshots' => 'api/v1/screenshots#create'
end
