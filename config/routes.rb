Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
