Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :shipping_modes, only: [:index, :new, :create, :show, :edit, :update] do
    post 'deactivate', on: :member
  end
end