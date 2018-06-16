Rails.application.routes.draw do
  require 'resque_web'

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "admin/resque_web"
  end

  resources :stalkees
  devise_for :users
  resources :users
  get 'visits', to: 'visits#index'
  resources :milestones
  resources :results
  root to: 'results#index'
  get 'scrapes', to: 'scrapes#index'
  get 'milestones', to: 'milestones#index'
  get 'maps', to: 'maps#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end