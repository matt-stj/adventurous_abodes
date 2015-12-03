Rails.application.routes.draw do
  root to: "home#index"
  resources :rentals, only: [:index, :show]
  resources :cart_rentals, only: [:new, :create]
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :orders, only: [:index, :show]
  resources :rental_types, only: [:index]
  resources :rental_types, param: :slug, only: [:show]

  get "/owners/dashboard", to: "owners/users#dashboard"

  namespace :owners do
    resources :rentals
    resources :orders
  end

  get "/cart", to: "cart_rentals#show"
  put "/cart", to: "cart_rentals#update"
  delete "/cart", to: "cart_rentals#delete"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#delete"
  get "/dashboard", to: "users#dashboard"
  post "/checkout", to: "orders#create"

  #get "/:rental_type_name", to: "rental_types#show" # keep at bottom of routes
  resources :owners, only: [:index, :show]
end
