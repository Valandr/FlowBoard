Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/login", to: "auth#login"
      post "auth/signup", to: "auth#signup"
      delete "auth/logout", to: "auth#logout"

      resources :users, only: [:show, :update]
      resources :figures, only: [:index]
      resources :recommendations, only: [:index]
    end
  end

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check
  root to: "rails/health#show"
end
