Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :bartenders do
    resources :bookings, only: [:new, :create, :show]
    resources :reviews, only: [:index, :show, :new, :create]
  end
    resources :reviews, only: [ :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
