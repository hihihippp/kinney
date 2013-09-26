Kinney::Engine.routes.draw do

  post "tracker/track", :to => 'tracker#track'
  # match "tracker/analyze/:video", :to => 'tracker#analyze', :via => :get, :as => 'tracker_analyze'

  get "search", :as => :search, :to => 'search#index'
  get "about", :as => :about, :to => 'pages#about'

  get 'giving', :as => :giving, :to => 'pages#giving'
  # get 'contact' => 'contact#new', :as => 'contact'
  # post 'contact' => 'contact#create', :as => 'contact'

  root :to => 'pages#home'

  resources :people, :only => [:index, :show]
  resources :topics, :only => [:index, :show]
  resources :clips,  :only => [:index, :show], :path => '/videos'

  mount Ckeditor::Engine => "/ckeditor"

  get "/sitemap" => "sitemap#index", :as => :sitemap,
    :defaults => {:format => :xml}

end
