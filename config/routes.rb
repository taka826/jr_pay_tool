Rails.application.routes.draw do
  get 'quizs/index'
  devise_for :users
  root to: 'railways#index'
  resources :railways do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :quizs, only: :index
  resources :users, only: :show
end
