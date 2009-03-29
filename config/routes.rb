ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'items'
  
  # Authentication
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.resources :transfers
  map.resources :types

  map.connect 'items/feed', :controller => 'items', :action => 'feed', :format => 'rss'
  map.resources :items
  map.connect 'items/type/:type', :controller => 'items', :action => 'index'

  map.user_items 'users/:login/items', :controller => 'items', :action => 'index'
  map.resource :account, :controller => "users", :path_names => {:edit => "modify"}
  map.resources :users, :only => [:new, :create, :edit, :update]

  map.resource :user_session, :as => "session"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect '/', :controller => 'items'
end
