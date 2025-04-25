Rails.application.routes.draw do
  # Devise user authentication
  devise_for :users

  # Admin namespace
  namespace :admin do
    root to: "dashboard#index"  # 👈 This enables /admin to route correctly
    resources :users, only: [:index, :new, :create, :edit, :update]
  end
  
  get '/create_admin_user', to: 'admin#temp_admin_create'

  # Root path for normal users
  root "vehicles#index"

  # Vehicles management
  resources :vehicles do
    collection do
      get :search
      get :results
    end
  end
end
