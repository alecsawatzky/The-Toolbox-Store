Rails.application.routes.draw do

  resources :products, only: [:index] do
    member do
    post :add_to_cart
    get :cart
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "products#index", as: 'root'
  
  get '/products/cart', to: 'products#cart', as: 'cart'

  get '/products/sale', to: 'products#sale', as: 'sale'
  
  get '/products/new', to: 'products#new', as: 'new'

  get '/product/:id', to: 'products#show', as: 'show', id: /\d+/

  get '/products/search', to: 'products#search', as: 'search'

  get '/products/filter', to: 'products#filter', as: 'filter'

end
