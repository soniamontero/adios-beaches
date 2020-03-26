Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: :registrations
    }

  resources :users, only: [:update]
  match 'edit_profile' => 'users#edit', via: [:get], as: 'edit_profile'
  match 'patch_profile' => 'users#update', via: [:patch]

  resources :experiences do
    resources :dones, only: [:create]
    resources :favorites, only: [:create]
    resources :votes, only: [:create]
  end

  resources :dones, only: [:destroy]
  resources :favorites, only: [:destroy]
  resources :votes, only: [:update, :destroy]

  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "/:github_username", to: "users#show", as: :user_profile
end
