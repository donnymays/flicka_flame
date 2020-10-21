Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'users#show' 
  devise_for :users
 
  resources :users do
    resources :images
    end
  resources :images
end
