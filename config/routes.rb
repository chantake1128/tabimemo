Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts
  resources :landmarks, only: [:new, :create]
end
