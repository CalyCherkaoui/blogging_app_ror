Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: "home#index"

  get 'home/index'
  get 'dashboard/index'

  resources :articles, :except => [:index] do
    resource :vote, module: :articles, only: [:create, :destroy]
  end

  resources :categories

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[show]
end
