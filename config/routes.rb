Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'users#home'
  get 'about', to: 'users#about'

  resources :users, only: [:index, :show]
end
