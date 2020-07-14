Rails.application.routes.draw do
  get '/home',      to: 'static_pages#home'
  get '/timer',     to: 'static_pages#timer', as: 'timey'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/register',  to: 'users#new'
  post '/register', to: 'users#create'
  resources :posts
  resources :users, except: :create

  root 'static_pages#home'
end
