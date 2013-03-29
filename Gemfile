source "http://rubygems.org"

# Declare your gem's dependencies in kinney.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem 'djatoka'
gem 'font-awesome-sass-rails'

group :development do 
  gem 'guard-livereload'
  gem 'rb-readline', :platforms => :ruby_19
  gem 'pry-rails'
end

# once these are published as gems we can use them from there, until then we need to have them in our Gemfile
gem 'mediaelement_rails', :git => 'https://github.com/tobsch/mediaelement_rails.git'
gem 'webvtt', :git => 'https://github.com/jronallo/webvtt.git'

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails',   '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'

#gem 'bootstrap-sass', '~> 2.0.3'
gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass', :branch => '2.1-wip'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'

group :tools do
  gem 'guard-test'
end

group :test do
  gem 'vcr'
  gem 'webmock', ['>= 1.8.0','< 1.9.0']
  # gem 'capybara-webkit'
  # gem 'poltergeist'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
