Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'delivery_lookup', to: 'deliveries#lookup'
  resources :shipping_modes, only: [:index, :new, :create, :show, :edit, :update] do
    post 'deactivate', on: :member
    resources 'delivery_times', only: [:create, :index, :edit, :update] do 
      post 'disable', on: :collection
    end
    resources 'distance_based_fees', only: [ :create, :index, :edit, :update] do
      post 'disable', on: :collection
    end
    resources 'weight_based_fees', only: [ :create, :index, :edit, :update] do
      post 'disable', on: :collection
    end
    
  end
  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do
    resources :vehicle_shipping_modes, only: [:new, :create, :destroy]
    get 'search', on: :collection
  
  end

  resources :service_orders, only: [:index, :new, :create, :show] do 
    get 'closed', on: :collection
    post 'initialize_delivery_of', on: :member
    post 'close_delivery_of', on: :member
    resources :delay_reasons, only: [:new, :create]
  end
  
  

end
