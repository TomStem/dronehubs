Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :jobs, only: [:index, :show] do
    resources :bids, only: [:new, :create]
  end

  resources :owners, only: [:index, :show]

  namespace :inquirer do
    resources :jobs do
      resources :bids, only: [] do
        member do
          patch :accept
        end
      end
    end
  end

  namespace :owner do
    resource :profile, only: [:show, :edit, :update]

    resources :drones
  end

  resources :jobs do
    collection do
      get 'latest', to: "jobs#latest"
    end
  end
end
