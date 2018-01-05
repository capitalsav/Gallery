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

    root  'static_pages#home'
    resources :categories, only: [:new, :index, :create] do
      resources :subscriptions, only: [:create, :destroy]
    end
    resources :images, only: [:index, :upload_remote] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
    match '/categories/:id', to: 'categories#show_images', via: 'get', as: 'single_category'
    match '/categories/:id/new_image', to: 'categories#new_image', via: 'get', as: 'new_image'
    match '/categories/:id/:image_id', to: 'categories#show_one_image', via: 'get', as: 'single_category_image'
    match '/comments', to: 'comments#index', via: 'get', as: 'comments'
    match '/categories/:id/create_image', to: 'categories#create_image', via: 'post', as: 'create_image'
    match '/images/upload_remote', to: 'images#upload_remote', via: 'post', as: 'upload_remote_image'
  end
end
