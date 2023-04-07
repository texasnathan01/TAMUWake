Rails.application.routes.draw do
  root 'account#index'

  resources :wakeboard_sets, :path => "/sets" do
    member do
      post 'join'
      post 'leave'
    end
  end
  resources :receipts

  resources :users do
    member do
      post 'addrole'
      post 'removerole'
    end 
  end

  get 'approval', to: 'users#approval', as: 'users_to_approve'
  get 'help', to: 'help#index'
  
  get 'account', to: 'account#index', as: :accounts
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
    resources :admins do 
      member do 
        patch :update_approval 
        post 'add_role'
        post 'remove_role'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
