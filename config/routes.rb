Rails.application.routes.draw do
  get 'quizs/index'
  devise_for :users
  root to: 'railways#index'
  resources :railways, only: [:index, :new, :create, :destroy]
  resources :quizs, only: :index
end
