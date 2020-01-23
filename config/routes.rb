Rails.application.routes.draw do
  resources :posts do
    resources :like_posts, only: %i[create destroy]
    resources :comments
  end
  resources :users, only: %I[index show]
  # get 'users/index'
  root to: 'users#index'
  devise_for :users, path_prefix: 'auth'
end
