Rails.application.routes.draw do
  root 'events#index'

  match '/forgot-password' => 'password_resets#new', via: :get, as: :new_password_reset
  match '/forgot-password' => 'password_resets#create', via: :post, as: :create_password_reset
  match '/password-resets/:token' => 'password_resets#edit', via: :get, as: :edit_password_reset
  match '/password-resets/:token' => 'password_resets#update', via: :patch, as: :update_password_reset
  match '/change-password' => 'password_updates#edit', via: :get, as: :edit_password
  match '/change-password' => 'password_updates#update', via: :patch, as: :update_password

  match '/sign-in' => 'session#new', via: :get, as: :sign_in
  match '/sign-in' => 'session#create', via: :post, as: :authenticate
  match '/sign-out' => 'session#destroy', via: :get, as: :sign_out

  match '/api/username-uniqueness' => 'api#username_uniqueness', via: :get

  resources :users
  resources :events
  match '/calendar(/:year/:month)' => 'events#index', via: :get, as: :monthly_calendar


end
