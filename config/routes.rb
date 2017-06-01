Rails.application.routes.draw do
  get 'pages/index'

  devise_for :users
  root to: 'home#index'

  # Detections
  get 'detections' => 'detection#index'

  # ForAPI
  # User
  get '/api/v1/users' => 'api/v1/users#index'

  # Screenshot
  post '/api/v1/screenshots' => 'api/v1/screenshots#create'
end
