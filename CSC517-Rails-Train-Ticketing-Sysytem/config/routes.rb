Rails.application.routes.draw do
  get 'bookings/new'
  get 'bookings/create'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :trains do
    resources :reviews
    collection do
      get 'search'
    end
    member do
      post 'book'
      delete 'cancel_booking'
    end
  end
  resources :trains
  resources :reviews, only: [:index]
  resources :reviews do
    collection do
      get 'search'
    end
  end
  resources :bookings, only: [:index]
  resources :bookings do
    collection do
      get 'search'
    end
  end
  root 'home#index'
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get 'highly_rated_trains', to: "trains#get_highly_rated_trains", as: 'highly_rated_trains'
  resources :bookings, only: [:show]
end
