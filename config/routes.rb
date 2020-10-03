Rails.application.routes.draw do
  root              to: 'users#home'
  get 'about',      to: 'users#about'
  get 'search',     to: 'posts#search'
  post 'posts/new', to: 'posts#isbn'
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
  resources :posts, only: %i[new show create destroy]
end
