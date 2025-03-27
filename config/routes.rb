Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "users/index"
  get "users/show"
  get "users/showgroup"
  get "users/create"
  get "users/update"
  get "users/destroy"
  get "group_user/index"
  get "group_user/show"
  get "group_user/create"
  get "group_user/update"
  get "group_user/destroy"
  get "posts/index"
  get "posts/show"
  get "posts/create"
  get "posts/update"
  get "posts/destroy"
  # post '/signin', to: 'sessions#signin'
  post '/signin', to: 'sessions#create'
  post '/destroy', to: 'sessions#destroy'
  post '/create', to: 'regitster#create'
  get '/current_user', to: 'application#current_user'
  resources :users
  resources :group_user
  resources :posts
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
