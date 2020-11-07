Rails.application.routes.draw do
  root to: 'railways#index'
  resources :railways, only: :index
end
