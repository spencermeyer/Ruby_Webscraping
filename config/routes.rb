Rails.application.routes.draw do
  resources :runs
  # resources :scrapes
  root to: 'results#index'
  get 'scrapes', to: 'scrapes#index'
  resources :results
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
