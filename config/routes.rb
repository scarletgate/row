Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :check, :withdrawal] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'favorites' => 'favorites#index', as: 'favorites'
  end
  get 'users/:id/check' => 'users#check', as: 'check_user'
  patch 'users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  resources :posts do
    resources :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  get '/search' => 'searchs#search'
  resources :notifications, only: [:index]
  delete 'notifications' => 'notifications#destroy_all'
  resources :inquiries, only: [:new, :create]
  post 'inquiries/confirm' => 'inquiries#confirm', as: 'confirm'
  post 'inquiries/back' => 'inquiries#back', as: 'back'
  get 'inquiries/done' => 'inquiries#done', as: 'done'
end
