Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated :user do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end


  resources :families do
    resources :invitees, only: [:index, :create, :destroy]
  end

  resources :family_members, only: [:update, :destroy]

  resources :users, only: [] do
    resources :invitees, only: [:index, :update, :destroy], controller: 'user_invitees'
  end

  resources :posts do
    resources :comments, only: :create
  end

  resources :post_images, only: :destroy
  resources :post_videos, only: :destroy
  resources :comments, only: [:edit, :update, :destroy]
end
