# Kinney

An oral history video clips site packaged as a Rails gem.

# Story

This code was originally part of a site (currently unreleased) created for the [Student Leadership Initiative](http://news.lib.ncsu.edu/scrc/category/student-leaders/). The codename for the internal project is Sleader, so this project was named Kinney. 

Abstracting the code out into this Rails Engine is currently incomplete and possibly unusable, but it is ongoing. We are currently in the process of moving over to using this plugin for our own work.

# Install

1. Create a fresh Rails application
2. Add the following to your Gemfile: 
`gem 'kinney', :git => 'git://github.com/jronallo/kinney.git'`
3. `bundle`
4. `rake kinney:install:migrations` and `rake db:migrate`
5. `rails g kinney:install`
6. `rails c` and then Kinney::AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
7. Start the Rails server and go to localhost:3000/admin
8. Add a topic
9. Add a person
10. Add a clip (make at least one clip a "top pick")

# Author

Jason Ronallo

# License

See MIT-LICENSE.