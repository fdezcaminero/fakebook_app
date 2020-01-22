Rails.application.routes.draw do
  resources :posts
  resources :users, only: %I[index]
  # get 'users/index'
  root to: 'users#index'
  devise_for :users
end
