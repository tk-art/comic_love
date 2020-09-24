Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'users#home'
  get 'about', to: 'users#about'
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
  resources :relationships, only: %i[create destroy]
end
