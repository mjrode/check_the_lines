Rails.application.routes.draw do

  get 'pages/home'
  get 'pages/about'

  get 'pages/admin'

  get 'pages/fetch_data'

  resources :games do
    collection do
      get 'unplayed'
      get 'played'
      get 'best_bets'
      get 'old_best_bets'
      get 'old_over_under_best_bets'
    end
  end

 resources :sports do
   collection do
     get 'ncaaf'
     get 'refresh'
   end
 end

 resources :admin do
  collection do
    post 'fetch_data'
  end
 end

  get 'ncaaf', to: 'sports#ncaaf'
  get 'best_bets', to: 'sports#best_bets'
  post 'ncaaf', to: 'sports#ncaaf'
  get 'nfl', to: 'sports#nfl'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # root 'welcome#index'
  root 'sports#ncaaf'

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
