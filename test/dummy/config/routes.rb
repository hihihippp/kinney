Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :admin_users, :class_name => 'Kinney::AdminUser'
  mount Kinney::Engine => "/kinney", :as => 'kinney'
  root :to => 'kinney/pages#home'
end
