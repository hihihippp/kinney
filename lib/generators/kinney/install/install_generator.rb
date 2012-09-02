module Kinney
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc <<DESC
Description:
    Copy timeline_keeper files to your application.
DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def remove_public_index
        remove_file 'public/index.html'
      end

      # Kinney setup
      def inject_js
        inject_into_file "app/assets/javascripts/application.js", :after => "//= require_tree ." do
          "\n//= require kinney\n"
        end
        gsub_file 'app/assets/javascripts/application.js', "//= require_tree .", ''
      end

      def inject_css
        application_css_scss = "app/assets/stylesheets/application.css.scss"
        application_css = "app/assets/stylesheets/application.css"
        css_file = File.exist?(application_css_scss) ? application_css_scss : application_css
        
        inject_into_file css_file, :before => " *= require_self" do
          " *= require kinney\n"
        end
        gsub_file css_file, "*= require_tree .\n", ''
      end

      # create KinneyHelper
      def create_kinney_helpers
        template 'kinney_helper.rb', 'app/helpers/kinney_helper.rb'
        template 'kinney_clip_helper.rb', 'app/helpers/kinney_clip_helper.rb'
      end

      def create_image_override
        empty_directory 'app/models/kinney'
        template 'image.rb', 'app/models/kinney/image.rb'
      end

      def inject_routes
        routes = <<EOF

  ActiveAdmin.routes(self)
  devise_for :admin_users, :class_name => 'Kinney::AdminUser' #ActiveAdmin::Devise.config.merge(:class_name => Kinney::AdminUser)  
  mount Ckeditor::Engine => "/ckeditor"
  mount Kinney::Engine => "/kinney", :as => 'kinney'
  root :to => 'kinney/pages#home'

EOF
        inject_into_file 'config/routes.rb', :after => 'routes.draw do' do 
          routes
        end
      end

      def create_devise_initializer
        template 'devise.rb', 'config/initializers/devise.rb'
      end


      # ActiveAdmin setup
      def create_active_admin_css
        template 'active_admin.css.scss', 'app/assets/stylesheets/active_admin.css.scss'
      end

      def create_active_admin_js
        template 'active_admin.js', 'app/assets/javascripts/active_admin.js'
      end

      def copy_initializer
        template 'active_admin.rb', 'config/initializers/active_admin.rb'
      end

      # Google Analytics setup
      def inject_google_id
        inject_into_file 'config/application.rb', :after => "Rails::Application" do
          "\nconfig.kinney = ActiveSupport::OrderedOptions.new\nconfig.kinney.google_analytics_id = 'UA-XXXXXXXX-X'"
        end
      end

      def add_gems
        gems = <<EOF


# added by Kinney
gem 'bootstrap-sass'
# once these are published as gems we can use them from there, until then we need to have them in our Gemfile
gem 'mediaelement_rails', :git => 'https://github.com/tobsch/mediaelement_rails.git'
gem 'webvtt', :git => 'https://github.com/jronallo/webvtt.git'

EOF
        inject_into_file 'Gemfile', :after => "source 'https://rubygems.org'" do 
          gems
        end
      end

      def mailer_setup
        mailer_config = <<EOF

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :test #:sendmail
  config.action_mailer.sendmail_settings = {
    :location => '/usr/sbin/sendmail',
    :arguments => '-i -t'
  }

EOF
        inject_into_file 'config/environments/development.rb', :after => 'Application.configure do' do 
          mailer_config
        end
      end




    end
  end
end