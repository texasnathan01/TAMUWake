Rails.application.routes.draw do
  resources :wakeboard_sets, :path => "/sets" do
    member do
      post 'join'
      post 'leave'
    end
  end
  resources :receipts
  resources :users
  get 'approval', to: 'users#approval', as: 'users_to_approve'
  # resources :admins
  

  get 'account', to: 'account#index', as: :accounts

  root 'receipts#index'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
    resources :admins
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
