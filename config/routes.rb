Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :user do
    match '/profile', to: 'users/registrations#profile', via: 'get'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  root  'static_pages#home'
  resources :categories, only: [:new, :index, :create] do
    resources :subscriptions, only: [:create, :destroy]
  end
  resources :images, only: [:edit, :create, :update, :destroy, :index, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  match '/categories/:name', to: 'categories#show_images', via: 'get', as: 'single_category'
  match '/categories/:name/:image_id', to: 'categories#show_one_image', via: 'get'
  match '/comments', to: 'comments#index', via: 'get', as: 'comments'
  match '/categories/:name/:id/new_image', to: 'categories#new_image', via: 'get', as: 'new_image'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
