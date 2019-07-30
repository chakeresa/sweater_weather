Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecasts#show'
      get 'backgrounds', to: 'backgrounds#show'
      get 'munchies', to: 'munchies#index'
      post 'road_trip', to: 'road_trips#create'
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
