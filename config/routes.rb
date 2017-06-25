Rails.application.routes.draw do
  resources :projects, shallow: true do
    resources :tasks
  end

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

  # Activity
  post '/api/v1/activities' => 'api/v1/activities#create'
end
