Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :admin_users, :class_name => 'Kinney::AdminUser' #ActiveAdmin::Devise.config.merge(:class_name => Kinney::AdminUser)  
  mount Ckeditor::Engine => "/ckeditor"
  mount Kinney::Engine => "/kinney", :as => 'kinney'
  root :to => 'kinney/pages#home'
end
