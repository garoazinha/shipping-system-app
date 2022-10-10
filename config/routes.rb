Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :shipping_modes, only: [:index, :new, :create, :show, :edit, :update] do
    post 'deactivate', on: :member
  end
  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do
    resources :vehicle_shipping_modes, only: [:new, :create, :destroy]
  end

end
