Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    resources :comments
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
