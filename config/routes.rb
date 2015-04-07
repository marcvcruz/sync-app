Rails.application.routes.draw do
  root 'welcome#index'

  match '/forgot-password' => 'password_resets#new', via: :get, as: :new_password_reset
  match '/forgot-password' => 'password_resets#create', via: :post, as: :create_password_reset
  match '/password-resets/:token' => 'password_resets#edit', via: :get, as: :edit_password_reset
  match '/password-resets/:token' => 'password_resets#update', via: :put, as: :update_password_reset

  match '/sign-in' => 'session#new', via: :get, as: :sign_in
  match '/sign-in' => 'session#create', via: :post, as: :authenticate
  match '/sign-out' => 'session#destroy', via: :get, as: :sign_out

  resources :users

end
