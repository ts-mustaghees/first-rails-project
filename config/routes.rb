Rails.application.routes.draw do
  get '/home', { to: 'static_pages#home' }
  get '/timer', to: 'static_pages#timer', as: 'timey'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  resources :posts
  resources :users

  root 'static_pages#home'
end
