Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: "api/v1/sessions",
        registrations: "api/v1/registrations",
        passwords: "api/v1/passwords"
      }

      devise_scope :user do
        delete "users/sign_out", to: "api/v1/sessions#destroy", as: :destroy_user_session
      end

      resource :profile, only: [ :show, :update ]
      # Routes pour les utilisateurs et leurs expériences
      resources :users, only: [:index, :show] do
        resources :experiences, only: [:index, :create, :show, :update, :destroy]
      end
    end
  end


  namespace :api do
    namespace :v1 do
      resources :experiences, only: [:index, :create, :show, :update, :destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
