source "http://rubygems.org"

# Declare your gem's dependencies in kinney.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# needs to be added manually since rails 4 activeadmin is not released yet so can't go into gemspec
gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git', branch: 'master'

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem 'font-awesome-rails'
gem 'compass-rails', '>= 2.0.alpha.0'  #github: 'milgner/compass-rails', branch: 'rails4'

# for travisci testing under these two databases
gem 'mysql2'
gem 'pg'

group :development do
  gem 'guard-livereload'
  gem 'pry-rails'
  gem 'single_test'
  gem 'deadweight'
  gem 'guard-minitest'
  gem 'annotate', ">=2.5.0"
end

# once these are published as gems we can use them from there, until then we need to have them in our Gemfile
gem 'mediaelement_rails'
gem 'webvtt', :git => 'https://github.com/jronallo/webvtt.git'

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails', '~> 4.0.0'

gem 'bootstrap-sass', git: 'https://github.com/thomas-mcdonald/bootstrap-sass.git', branch: 'master'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'

group :tools do
  gem 'guard-test'
end

group :test do
  gem 'vcr'
  gem 'webmock' #, ['>= 1.8.0','< 1.9.0']
  gem 'microdata'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

