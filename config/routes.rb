Rails.application.routes.draw do
  resources :posts do
    resources :like_posts, only: %i[create destroy]
    resources :comments, only: %i[create] do
      resources :like_comments, only: %i[create destroy]
    end
  end
  resources :users, only: %I[index show]
  # get 'users/index'
  root to: 'users#index'
  devise_for :users, path_prefix: 'auth'
end
