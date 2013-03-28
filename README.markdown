# Kinney

An oral history video clips site packaged as a Rails gem.

[![Build Status](https://travis-ci.org/jronallo/kinney.png)](https://travis-ci.org/jronallo/kinney)

# Story

This code was originally part of a site (currently unreleased) created for the [Student Leadership Initiative](http://news.lib.ncsu.edu/scrc/category/student-leaders/). The codename for the internal project is Sleader, so this project was named Kinney. 

Abstracting the code out into this Rails Engine is currently incomplete and possibly unusable, but it is ongoing. We are currently in the process of moving over to using this plugin for our own work.

# Install

1. Create a fresh Rails application
2. Add the following to your Gemfile: 
```
gem 'kinney', :git => 'git://github.com/jronallo/kinney.git'
gem 'font-awesome-sass-rails'
```
3. `bundle install`
4. `rake kinney:install:migrations` and `rake db:migrate`
5. `rails g kinney:install` and `bundle install`
6. `rails c` and then Kinney::AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
7. Start the Rails server and go to localhost:3000/admin
8. Add a topic
9. Add a person
10. Add a clip (make at least one clip a "top pick")

# Configuration

When running the Kinney installation generator several files were created and some of those need to be configured.

## app/helpers/kinney_helper.rb

## app/helpers/kinney_clip_helper.rb

## app/models/kinney/image.rb

## config/routes.rb

## config/environments/development.rb

## app/views/kinney/pages/_about_text.html.erb

## app/views/kinney/_contact.html.erb

## app/views/layouts/kinney/_footer.html.erb

## app/views/layouts/kinney/_brand.html.erb

## app/views/kinney/pages/_home_header.html.erb


# Development

`bundle exec rake test`

# TODO

- more documentation
- sort out compiling ckeditor in production
- work around for this issue with ckeditor for deployment: https://github.com/galetahub/ckeditor/pull/156
- add generator for adding MailerLogger to main app
- generate application_name helper

# Author

Jason Ronallo

# License

See MIT-LICENSE.