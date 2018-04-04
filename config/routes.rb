Rails.application.routes.draw do

  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  post '/signup',  to: 'users#create'

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

  resources :competitions

  post "competitions/:id"  => "submissions#check", :as => 'submission_check'

  get  '/status',   to: 'static_pages#status'

  get "competitions/show_image" => "competitions#show_image"
  # resources :submissions
  # get 'sessions/new'

  # get  '/signup',  to: 'users#new'

  # get 'static_pages/help'
  # get 'static_pages/about'
  # get  'static_pages/contact'

  # resources :microposts
  # resources :users

  # root 'application#hello'
  # root 'users#index'

end
