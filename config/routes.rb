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
  resources :categories, only: [:new, :index]
  resources :images, only: [:new, :edit, :create, :update, :destroy]
  match '/categories/:name', to: 'categories#show_images', via: 'get'
  match '/categories/:name/:image_id', to: 'categories#show_one_image', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
