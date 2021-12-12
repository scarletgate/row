Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :check, :withdraw]
  get 'users/check' => 'usrs#check', as: 'check_user'
  patch 'users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  resources :posts
end
