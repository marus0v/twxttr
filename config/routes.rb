Rails.application.routes.draw do
  root "posts#index"

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :sessions

  resources :posts do
    resources :comments
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
