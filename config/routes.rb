Rails.application.routes.draw do
  devise_for :users
  
  root "vehicles#index"

  resources :vehicles do
    collection do
      get :search
      get :results
    end
  end
end
