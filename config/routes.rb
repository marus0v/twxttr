Rails.application.routes.draw do
  root "posts#index"

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :sessions, only: [ :new, :create, :destroy ]

  resources :posts do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
