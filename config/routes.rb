Rails.application.routes.draw do
  root               to: 'users#home'
  get 'about',       to: 'users#about'
  get 'search',      to: 'posts#search'
  get 'searching',   to: 'users#search'
  post 'searching',  to: 'users#search'
  post 'posts/new',  to: 'posts#isbn'
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: %i[index show] do
    member do
      get :following, :followers
    end
  end

  resources :posts, only: %i[new show edit update create destroy] do
    resources :comments, only: %i[create]
  end

  resources :relationships, only: %i[create destroy]
  resources :categories,    only: %i[show]
  resources :notifications, only: %i[index destroy]
end
