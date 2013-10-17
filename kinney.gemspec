$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kinney/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kinney"
  s.version     = Kinney::VERSION
  s.authors     = ["Jason Ronallo"]
  s.email       = ["jronallo@gmail.com"]
  s.homepage    = "https://github.com/jronallo/kinney"
  s.summary     = "An oral history video clips site packaged as a Rails gem."
  s.description = "An oral history video clips site packaged as a Rails Engine gem."
  s.license     = "MIT-LICENSE"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency 'active_admin_editor'
  s.add_dependency "friendly_id", "~> 5.0.0.rc1"
  s.add_dependency 'formtastic', "~> 2.3.0.rc2"
  s.add_dependency 'chosen-rails'
  s.add_dependency 'tire'
  s.add_dependency 'jquery-tablesorter'
  s.add_dependency "html_truncator"
  s.add_dependency 'httpclient'
  s.add_dependency 'font-awesome-sass-rails'
  s.add_dependency 'strip_attributes'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'capybara', "~> 2.1.0"
  s.add_development_dependency 'database_cleaner', '<1.1.0'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'capybara-webkit'
end
