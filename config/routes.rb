Rails.application.routes.draw do
  resources :projects, shallow: true do
    resources :tasks
  end

  put 'schedule/:id' => 'tasks#update_schedule', as: :update_schedule

  get 'pages/index'
  get 'pages/diff'

  devise_for :users
  root to: 'home#index'

  # Detections
  get 'detections' => 'detection#index'

  # ForAPI
  # User
  get '/api/v1/users' => 'api/v1/users#index'

  # Screenshot
  post '/api/v1/screenshots' => 'api/v1/screenshots#create'

  post '/api/v1/screenshots/diff' => 'api/v1/screenshots#diff'

  # Activity
  post '/api/v1/activities' => 'api/v1/activities#create'

  get 'activity/:project_id/:year/:month/:day' => 'activity#index'
end
