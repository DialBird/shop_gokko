Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :products

  get '/cart' => 'carts#edit'
  put '/populate_cart' => 'carts#populate'
  put '/update_cart' => 'carts#update'
  get '/cart_link' => 'carts#cart_link'

  get '/checkout' => 'checkout#edit'
  post '/update_checkout' => 'checkout#update'
end
