Rails.application.routes.draw do

  namespace :api, path: '/', defaults: { format: :json } do
    namespace :v1 do
      post 'auth/login' => 'users#login', as: :login
      get 'auth/logout' => 'users#logout', as: :logout
      resources :users, only: [:create]
      resources :bucketlists, except: [:new, :edit] do
        resources :items, path: '/', only: [:create]
      end
    end
  end

  get '/', to: redirect('http://docs.mylyst.apiary.io')
  match "*path", to: 'application#no_route_found', via: :all
  # get '/', to: redirect('/v1/bucketlists')

  #-> (env) {[400, {}, ['{errors: "The resource you are trying to call does not exist"}']]}, via: :all
  # get '*unmatched_route', to: 'application#no_route_found'
  # , constraints: {subdomain: 'api'}
  # constraints: {subdomain: 'api'},
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
