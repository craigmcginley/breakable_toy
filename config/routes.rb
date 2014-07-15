Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :families do
    resources :invitees, only: [:index, :create]
  end

  resources :posts do
    resources :comments, only: :create
  end

  resources :comments, only: [:edit, :update, :destroy]

  resources :users, only: [] do
    resources :invitees, only: [:index, :update, :destroy], controller: 'user_invitees'
  end
end
