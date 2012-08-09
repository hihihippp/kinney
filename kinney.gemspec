$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kinney/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kinney"
  s.version     = Kinney::VERSION
  s.authors     = ["Jason Ronallo"]
  s.email       = ["jronallo@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "An oral history video clips site packaged as a Rails gem."
  s.description = "An oral history video clips site packaged as a Rails gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8.rc2"
  s.add_dependency 'ckeditor', '3.7.1'
  s.add_dependency "friendly_id", "~> 4.0.1"
  s.add_dependency 'activeadmin'
  s.add_dependency 'meta_search'
  s.add_dependency 'formtastic-bootstrap'
  s.add_dependency 'chosen-rails'
  s.add_dependency 'tire' 
  s.add_dependency 'jquery-tablesorter' 
  s.add_dependency "html_truncator", "~>0.2"
  s.add_dependency 'httpclient'
  #s.add_dependency "bootstrap-sass", '~> 2.0.3'

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'thin'
  s.add_development_dependency 'sextant'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'djatoka'
  s.add_development_dependency 'mocha'
end
