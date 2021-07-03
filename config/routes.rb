Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :likes
    end
  end
  
  resources :questions, only: [:show, :new, :create, :edit, :update, :destroy] do 
    collection do
      get :search
    end
  end
  
  resources :favorites, only: [:create, :destroy]
  resources :answers, only: [:show, :new, :create, :destroy]
end
