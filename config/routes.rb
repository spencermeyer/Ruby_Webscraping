Rails.application.routes.draw do
  # resources :scrapes
  root to: 'scrapes#index'
  get 'scrapes', to: 'scrapes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
