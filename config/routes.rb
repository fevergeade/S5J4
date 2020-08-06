Rails.application.routes.draw do
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  root to: 'gossips#index'
  get '/welcome', to: 'gossips#index'
  get '/welcome/:id', to: 'gossips#show'
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :private_messages, only: [:create, :edit, :update, :destroy]
  resources :tags, only: [:create, :destroy]
  resources :users
  resources :gossips
  resources :cities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
