Rails.application.routes.draw do
  root 'home#index'

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
  get 'home', to: 'home#index'

  get 'account', to: 'account#index', as: :accounts
  get 'account/history', to: 'account#history', as: :set_history
  post 'account/history', to: 'account#history'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
    resources :admins do 
      member do 
        patch :update_approval 
        post 'add_role' # route to add a role using join table
        post 'remove_role' # route to remove a role using join table
        post 'show_role' # route to display all the roles assigned to a user on the admins page
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
