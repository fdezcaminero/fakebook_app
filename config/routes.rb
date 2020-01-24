Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, path_prefix: 'auth'

  resources :posts do
    resources :like_posts, only: %i[create destroy]
    resources :comments, only: %i[create] do
      resources :like_comments, only: %i[create destroy]
    end
  end
  resources :users, only: %I[index show] do
    resources :friendship, only: %i[create update]
  end
  # get 'users/index'
end
