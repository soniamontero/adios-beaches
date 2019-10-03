Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
      # registrations: :registrations
    }

  resources :users, only: [:update]
  match 'edit_profile' => 'users#edit', via: [:get], as: 'edit_profile'
  match 'patch_profile' => 'users#update', via: [:patch]

  resources :experiences
end
