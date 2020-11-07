Rails.application.routes.draw do
  devise_for :users
  root to: 'railways#index'
  resources :railways, only: :index
end
