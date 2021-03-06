Trunk::Application.routes.draw do
  get "features/index"
  get 'class/sorted'
  get "add_course/add_course"
  get "landing/thankyou"
  resources :landings
	resources :class


  get ':controller(/:action(/:id))(.:format)'
	post ':controller(/:action(/:id(.:format)))'
	
   root :to => 'landings#index'
  get "upload/index"
 resources :upload do
  collection { post :import }
end
 resources :lecturer do
  collection { post :create }
end
 resources :lecturer do
  collection { post :import }
end
 resources :class do
  collection { post :create }
end
 resources :class do
  collection { post :import }
end
  get "login/login"
  get "signup/signup"

  get "contact/contact"
  get "sort/index"
  get "contact/index"
  get "about/privacy"
  get "about/index"
  get "class/index"
  get "lecturer/index"
  get "signup", :to => "signup#signup"
  get "login", :to => "login#login"
  get "home", :to => "lecturer#index"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   

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
