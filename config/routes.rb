require 'resque/server'

Rails.application.routes.draw do

  scope "(:locale)", locale: /en|ru/ do
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
    # mount Resque::Server.new, :at => "/resque" #use for development

    root  'static_pages#home'
    resources :categories, only: [:show, :new, :index, :create] do
      resources :subscriptions, only: [:create, :destroy]
    end
    resources :images, only: [:index, :upload_remote] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
    match '/categories/:id/new_image', to: 'images#new', via: 'get', as: 'new_image'
    match '/categories/:id/:image_id', to: 'images#show', via: 'get', as: 'single_category_image'
    match '/comments', to: 'comments#index', via: 'get', as: 'comments'
    match '/categories/:id/create_image', to: 'images#create', via: 'post', as: 'create_image'
  end
end
