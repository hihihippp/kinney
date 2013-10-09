# Kinney

An oral history video clips site packaged as a Rails gem.

[![Build Status](https://travis-ci.org/jronallo/kinney.png)](https://travis-ci.org/jronallo/kinney)

# Story

This code was originally part of the [Student Leadership Initiative](http://d.lib.ncsu.edu/student-leaders/). The codename for the internal project is Sleader, so this project was named Kinney.

# Requirements

- Rails 4
- ElasticSearch

# Install

1. Create a fresh Rails application
2. Add the following to your Gemfile:

```
gem 'kinney', :git => 'https://github.com/jronallo/kinney.git'
gem 'font-awesome-sass-rails'
```

These also need be added until the working versions are released as gems:
```
gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git', branch: 'master'
gem 'compass-rails', '>= 2.0.alpha.0'
gem 'bootstrap-sass', git: 'https://github.com/thomas-mcdonald/bootstrap-sass.git', branch: 'master'
```

3. `bundle install`
4. `rake kinney:install:migrations` and `rake db:migrate`
5. `rails g kinney:install` and `bundle install`
6. Add a devise secret key to :

```
config.secret_key = 'a better secret key than this'
```

7. `rails c` and then `Kinney::AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')`
8. Start the Rails server and go to localhost:3000/admin
9. Add a topic
10. Add a person
11. Add a clip (make at least one clip a "top pick")

# Configuration

When running the Kinney installation generator several files were created and some of those need to be configured.

## Generated

### app/helpers/kinney_helper.rb
Defines how to get different sizes of images. You'll likely want to change these for how you need to get images. By default if the djatoka gem is installed it uses Djatoka, otherwise it falls back on a placeholder image.

### app/helpers/kinney_clip_helper.rb
Defines #siskel_path which is used in several places to calculate the URL to your HTML5 Video, poster images, and webvtt files. You will definitely want to update this method to reflect where your HTML5 Video is stored. Note that this current works by storing all access derivatives for a single video within one directory.

### app/models/kinney/image.rb
This file is generated so that the image model can have an #external_url method. This allows you to link out from an image modal to the original image where you might have more information about the resource.

### config/routes.rb

Routes are generated for admin interface, login, mounting the kinney engine, and ckeditor.

You may want to change where kinney is mounted to be at the root of your application:
```
mount Kinney::Engine => "/", :as => 'kinney'
```
You may have to restart your server for this change to show up.


### app/helpers/application_helper.rb

This file is not generated, but you will want to add your application name:

```
def application_name
  'Kinney'
end
```

### config/initializers/active_admin.rb

You may want to `config.site_title`.

### Google Analytics in config/application.rb

Update the generated google analytics id.

## Views to Override

You'll want to override all of these views. In some cases you may just want to include a blank template.

### app/views/kinney/pages/_about_text.html.erb
### app/views/kinney/_contact.html.erb

Both the _about_text and _contact partials show up on the about page and will need to be overridden in your own application.

### app/views/layouts/kinney/_footer.html.erb

You probably want more in your footer than just about and contact links.

### app/views/layouts/kinney/_brand_above_navbar.html.erb
### app/views/layouts/kinney/_brand_below_navbar.html.erb

These will need to be overridden to change the Sleater-Kinney orange that shows up above the main navbar.

### app/views/kinney/pages/_home_header.html.erb

If you need to have some kind of jumbotron on your home page, this is the file to update.

### config/environments/development.rb

FIXME: I can't remember what you might want to change in your development environment. Sorry!

# Rake tasks

`rake kinney:reindex` will reindex in elasticsearch.

# Development

`bundle exec rake test`

# Running the Dummy App

To index into ElasticSearch:

```
bundle exec rake environment app:tire:import CLASS='Kinney::Person'
bundle exec rake environment app:tire:import CLASS='Kinney::Clip'
```

You may need to drop the ElasticSearch index at time:

```
bundle exec rake environment app:tire:index:drop INDEX=kinney_dummy_development
```

Then you need to go into the dummy directory to start the app:

```
cd test/dummy
bundle exec rails s
```

# TODO

- Note that for production and staging environments the mailer must be set up
- config/initializers/devise.rb updated to include config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
- Note that app/assets/javascripts/kinney/admin/siskel_path.js should be overridden
- added gems should be generated in
- more documentation
- generate application_name helper

# Author

Jason Ronallo

# License

See MIT-LICENSE.