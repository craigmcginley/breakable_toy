Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :families do
    resources :invitees, only: [:index, :create]
  end

  resources :invitees, only: [:show, :update, :destroy]

  resources :posts do
    resources :comments, only: :create
  end
end
