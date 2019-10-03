Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
      # registrations: :registrations
    }
  root to: 'pages#home'
  resources :users, only: [:update]
  match 'edit_profile' => 'users#edit', via: [:get], as: 'edit_profile'
  match 'patch_profile' => 'users#update', via: [:patch]

end
