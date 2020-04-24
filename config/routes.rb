Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  resources :tasks
  root to: 'tasks#index'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
