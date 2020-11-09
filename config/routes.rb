Rails.application.routes.draw do
  get 'quizs/index'
  devise_for :users
  root to: 'railways#index'
  resources :railways
  resources :quizs, only: :index
  resources :users, only: :show
end
