Rails.application.routes.draw do
  resources :wakeboard_sets
  resources :receipts
  resources :users
  root 'receipts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
