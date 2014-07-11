Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :families

  resources :posts do
    resources :comments, only: :create
  end
end
