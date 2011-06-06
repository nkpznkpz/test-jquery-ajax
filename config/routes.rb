ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end


  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "task"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #
  #
  #  map.with_options :controller => 'comment' do |task_routes|
  #    task_routes.connect 'task/:task_name/comment/',:action => 'index',
  #                        :conditions => {:method => :get}
  #
  #    task_routes.connect 'task/:task_name/comment/:action',
  #                        :action => '/edit|delete/',
  #                        :conditions => {:method => :post}
  #  end
  map.connect 'logout/' ,:controller => 'user',:action => 'logout'
  map.connect 'login/' ,:controller => 'user',:action => 'login'





  
  map.with_options :controller => 'task' do |task_routes|
    task_routes.connect 'task/',
      :action=>'index',
      :conditions => {:method => :get}
    task_routes.connect 'task/:task_name/:id',
      :action=>'show',
      :conditions => {:method => :get}
    task_routes.connect 'task/:action.:format',
      :action=>'/create|delete|update/',
      :conditions => {:method => :post}
  end
  map.with_options :controller => 'user' do |task_routes|
    task_routes.connect 'user/',
      :action=>'index',
      :conditions => {:method => :get}
    task_routes.connect 'user/:name/:id',
      :action=>'show',
      :conditions => {:method => :get}
  end
  map.with_options :controller => 'comment' do |comment_routes|
    comment_routes.connect 'comment/:action.:format',
      :action=>'/create|delete/',
      :conditions => {:method => :post}
  end
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  #  map.resources :task  do |t|
  #    t.resources :comment
  #  end
 
end
