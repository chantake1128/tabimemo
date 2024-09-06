Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  resources :landmarks, only: [:new, :create]
end
