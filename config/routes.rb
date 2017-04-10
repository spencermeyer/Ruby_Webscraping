Rails.application.routes.draw do
  devise_for :users
  resources :users
  # resources :visits
  get 'visits', to: 'visits#index'
  # resources :runs
  # resources :scrapes
  resources :milestones
  resources :results
  root to: 'results#index'
  get 'scrapes', to: 'scrapes#index'
  get 'milestones', to: 'milestones#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
