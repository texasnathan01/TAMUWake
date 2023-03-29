Rails.application.routes.draw do
  
  resources :wakeboard_sets, :path => "/sets" do
    member do
      post 'join'
    end
  end
  resources :receipts
  # path to add and delete a role using user
  resources :users do
    member do
      post 'addrole'
      post 'deleterole'
    end 
  end

  root 'receipts#index'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
