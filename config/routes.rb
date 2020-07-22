Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords:     'users/passwords'
  }

  get '/home',      to: 'static_pages#home'
  get '/timer',     to: 'static_pages#timer', as: 'timey'

  resources :posts,               only: [:create, :update, :destroy]
  resources :users,               except: [:new, :create, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]

  root 'static_pages#home'
end
