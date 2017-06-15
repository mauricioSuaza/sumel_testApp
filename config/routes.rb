Rails.application.routes.draw do


  resources :messages , only: [:new, :create, :index]
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: "/"

  get '/tracker', to: 'shippings#tracker', as: 'track_shipment'
  get '/home_page' => 'spree/home#home_page'
  get '/catalog', to: 'catalog#index', as: 'catalog'

  get '/about', to: 'static#about', as: 'about'
  get '/terms', to: 'static#terms', as: 'terms'
  get '/empresa', to: 'static#empresa', as: 'empresa'
  get '/security', to: 'static#security', as: 'security'
  get '/contact', to: 'messages#new', as: 'contact'

  post '/subs', to: 'subscriptions#create', as: 'newsubscription'

  resources :subscriptions

  Spree::Core::Engine.routes.prepend do
    post '/cotizar', to: 'orders#cotizar', as: 'cotizar'
  end
  
  Spree::Core::Engine.add_routes do
    namespace :admin do
      resources :subscriptions
    end
    resources :subscriptions
  end

  #get '/contact', to: 'static#security', as: 'security'

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
