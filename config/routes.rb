Rails.application.routes.draw do

  root  'static_pages#home'
  resources :categories, only: [:new]
  resources :images
  match '/categories/:name', to: 'categories#show_images', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
