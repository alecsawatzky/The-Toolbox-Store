Rails.application.routes.draw do

  get 'authentication/login'

  get 'authentication/sign_up'

  post 'authentication/authenticate'

  post 'authentication/create'

  resources :products, only: [:index] do
    member do
      post :add_to_cart
      post :edit_quantity
      get :cart
      get :checkout
    end
  end

  resources :charges, only: [:new, :create]

  resources :authentication, only: [:authenticate]




  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "products#index", as: 'root'
  
  get '/authentication/create', to: 'authentication#create', as: 'create'
 
  get 'authentication/authenticate', to: 'authentication#authenticate', as: 'authenticate'

  get 'authentication/login', to: 'authentication#login', as: 'login'

  get '/products/cart', to: 'products#cart', as: 'cart'

  get '/products/sale', to: 'products#sale', as: 'sale'
  
  get '/products/new', to: 'products#new', as: 'new'

  get '/product/:id', to: 'products#show', as: 'show', id: /\d+/

  get '/products/search', to: 'products#search', as: 'search'

  get '/products/filter', to: 'products#filter', as: 'filter'

end
