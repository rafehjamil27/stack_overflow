Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'question_tags/new'

  get 'question_tags/create'

  get 'question_tags/destroy'

  get 'tags/new'

  get 'tags/create'

  get 'tags/destroy'

  resources :questions

  resources :users

  post 'users/:id/toggle_active' => 'users#toggle_active'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  controller :answers do
    get 'post_answer' => :new
    post 'post_answer' => :create
    delete 'answers/:id/delete' => :destroy
    get 'answers/:id/edit' => :edit
    patch 'answers/:id/edit' => :update
  end

  controller :comments do
    get 'comments/show' => :show
    get 'comments/:id/edit' => :edit
    patch 'comments/:id/edit' => :update
    post 'comments/create' => :create
    delete 'comments/:id/delete' => :destroy
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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
