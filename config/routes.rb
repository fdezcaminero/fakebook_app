Rails.application.routes.draw do
  resources :posts
  # get 'users/index'
  root to: 'users#index'
  devise_for :users
end
