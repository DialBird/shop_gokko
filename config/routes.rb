Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :products

  get '/cart' => 'carts#edit'
  put '/populate_cart' => 'carts#populate'
  put '/update_cart' => 'carts#update'
end
