Yueyue::Application.routes.draw do
  resources :accounts do
    collection do
      get 'forgot_password'
      get 'reset_password'
      post 'update_password'
    end
  end

  resources :messages do
    collection do
      get 'list'
    end
  end
  
  match 'send_msg/:type/:id' => 'messages#new'

  resources :groups do
    collection do
      get 'add_user'
      get 'delete_user'
      get 'invite_someone'
    end
  end

  get "city/index"

  get "city/change_city"

  get "city/index_by_letter"

  get "city/search"
  
  #get "yueyue_objects/list"

  #get "yueyue_objects/home"

  resources :yueyue_object_properties

  match 'yueyue_objects/join/:id' => 'yueyue_objects#join'
  resources :yueyue_objects do
    collection do
      get 'list'
      get 'home'
    end
  end

  resources :yueyue_type_actions

  resources :yueyue_type_properties

  resources :yueyue_types

  resources :users do
    collection do
      get 'login'
    end
  end
  
  match "weibo/:type/new" => "weibo#new", :as => :weibo_new
  match "weibo/:type/callback" => "weibo#callback", :as => :weibo_callback
  match "weibo/:type/write" => "weibo#write", :as => :weibo_write
  match "weibo/:type/test_it" => "weibo#test_it", :as => :weibo_test_it

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "yueyue_objects#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
