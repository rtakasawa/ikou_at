Rails.application.routes.draw do

  resources :tasks
  root to: 'tasks#index'
  # resources :tasks
  # # root "tasks/index"
end
