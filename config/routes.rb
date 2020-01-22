Rails.application.routes.draw do
  get 'users/index'
  root to: 'users#index'
  devise_for :users
end
