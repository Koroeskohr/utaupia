<<<<<<< HEAD
Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  # removes the users namespace to the sign_in and sign_out actions, and renaming them as login and logout
  devise_for :users, :path => '', :path_names => { :sign_in => 'login', 
                                                   :sign_out => 'logout', 
                                                   edit: 'account/edit' }

  resources :users, only: [:show, :index, :destroy, :edit]
  root to: 'utauloids#index', as: 'root_path'

  resources :utauloids
  resources :categories, only: [:show, :index]
  resources :voicebank_types, only: [:show, :index]
  resources :voice_characteristics, only: [:show, :index]
  resources :voice_languages, only: [:show, :index]

  resources :favorite_utauloids, only: [:create, :destroy]


  resources :user_links, only: [:create, :update, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
=======
Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end

  # removes the users namespace to the sign_in and sign_out actions, and renaming them as login and logout
  devise_for :users, :path => '', :path_names => { :sign_in => 'login', 
                                                   :sign_out => 'logout', 
                                                   edit: 'account/edit' }

  resources :users, only: [:show, :index, :destroy, :edit, :update]
  root to: 'utauloids#index', as: 'root_path'

  resources :utauloids
  resources :categories, only: [:show, :index]
  resources :voicebank_types, only: [:show, :index]
  resources :voice_characteristics, only: [:show, :index]
  resources :voice_languages, only: [:show, :index]


  resources :user_links, only: [:create, :update, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
>>>>>>> controllers-users-nested-ressources
