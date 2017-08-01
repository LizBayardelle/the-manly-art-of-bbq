Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
    resources :users, only: [:show, :update, :index]

  get 'home/index'
  root 'home#index'
  get 'home/lifehacks'
  get 'home/gifthelper'
  get 'home/error'
  get 'home/parallax'

  get 'gifts/babies'
  get 'gifts/kids'
  get 'gifts/teens'
  get 'gifts/adults'

  resources :principles, only: [:index]
  get 'principles/intro'
  get 'principles/intermediate'
  get 'principles/advanced'
  get 'principles/beef'
  get 'principles/steak'
  get 'principles/chicken'
  get 'principles/pork'
  get 'principles/fish'
  get 'principles/recipes'

  resources :suggestions, only: [:create, :index, :destroy] do
    patch :archive, on: :member
    patch :unarchive, on: :member
  end
    get 'suggestions/archives'

  resources :man_tests, only: [:new, :create]
    get 'man_tests/fail'

  resources :jokes do
    patch :approve, on: :member
    patch :reject, on: :member
    member do
      post :vote_up
      post :vote_down
    end
  end
  get 'home/jokes'
  get 'otherjokes/kids'
  get 'otherjokes/mixed'
  get 'otherjokes/men'
  get 'otherjokes/comeback'

  resources :recipes do
    patch :approve, on: :member
    patch :reject, on: :member
    member do
      post :vote_up
      post :vote_down
    end
  end
  get 'home/bbq'
  get 'other_recipes/all'
  get 'other_recipes/beef'
  get 'other_recipes/chicken'
  get 'other_recipes/fish'
  get 'other_recipes/other_meat'
  get 'other_recipes/veggies'

  resources :rules do
    patch :approve, on: :member
    patch :reject, on: :member
    member do
      post :vote_up
      post :vote_down
    end
  end

  resources :reminders
  resources :events

  resources :products
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :charges, only: [:new, :create]
  post 'charges/new'
  get 'charges/shipping'
  get 'charges/address'
  post 'charges/update_order'

  resources :orders, only: [:update, :edit, :show, :create, :index]
  get 'orders/update'
  put "orders/:id/mark_as_placed" => "orders#mark_as_placed", as: "mark_as_placed"
  put "orders/:id/mark_as_shipped" => "orders#mark_as_shipped", as: "mark_as_shipped"
  put "orders/:id/mark_as_cancelled" => "orders#mark_as_cancelled", as: "mark_as_cancelled"



end
