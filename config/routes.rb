Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :answers, only: [:create, :destroy, :edit, :update]

  resources :comments, only: [:create, :destroy, :edit, :update]

  resources :questions

  resources :users do
    member do
      post 'toggle_active'
    end
  end

  controller :votes do
    get 'votes/create' => :create
    delete 'votes/destroy' => :destroy
  end

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'questions#index'

end
