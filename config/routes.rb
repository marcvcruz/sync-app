Rails.application.routes.draw do
  root 'welcome#index'

  match '/sign-in' => 'session#new', via: :get, as: :sign_in
  match '/sign-in' => 'session#create', via: :post, as: :authenticate
  match '/sign-out' => 'session#destroy', via: :get, as: :sign_out

  resources :users
end
