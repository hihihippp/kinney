Kinney::Engine.routes.draw do

  post "tracker/track", :to => 'tracker#track'
  # match "tracker/analyze/:video", :to => 'tracker#analyze', :via => :get, :as => 'tracker_analyze'

  match "search", :as => :search, :to => 'search#index' 
  match "about", :as => :about, :to => 'pages#about'

  match 'giving', :as => :giving, :to => 'pages#giving'
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post

  root :to => 'pages#home'
  
  resources :people, :only => [:index, :show]
  resources :topics, :only => [:index, :show]
  resources :clips,  :only => [:index, :show], :path => '/videos'
 
  mount Ckeditor::Engine => "/ckeditor"
  
  match "/sitemap" => "sitemap#index", :as => :sitemap,
    :defaults => {:format => :xml}

end
