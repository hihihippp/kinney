Kinney::Engine.routes.draw do

  post "tracker/track"
  match "tracker/analyze/:video", :to => 'tracker#analyze'

  match "search", :as => :search, :to => 'search#index' 
  match "about", :as => :about, :to => 'pages#about'

  match 'add_your_story', :as => :add_your_story, :to => 'pages#add_your_story'
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
