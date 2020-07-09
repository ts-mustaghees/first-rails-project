Rails.application.routes.draw do
  get '/home', { to: 'static_pages#home' }
  get '/timer', to: 'static_pages#timer', as: 'timey'
  get '/register', to: 'users#new'
  resources :posts

  root 'static_pages#home'
end
