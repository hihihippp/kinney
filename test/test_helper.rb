# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'capybara/rails'
#require 'capybara/webkit'
require 'mocha/setup'
require 'selenium-webdriver'
require 'pry'
require 'microdata'

require 'vcr'
VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.ignore_request do |request|
    URI(request.uri).path.include?('__identify__') or 
    URI(request.uri).path.include?('hub/session')
  end
  c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = false
end


Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class ActiveSupport::TestCase
  fixtures :all

  def admin_login
    visit new_admin_user_session_path
    if !page.has_content?("You are already signed in.")
      fill_in "admin_user_email", :with => 'admin@example.com'
      fill_in "Password", :with => 'password'
      click_button "Sign in"
      sleep 0.2 # For some reason without this there are test failures
    end
  end

  def browser_start
    Capybara.current_driver = :selenium #_with_long_timeout
  end
  
  def browser_end
    Capybara.use_default_driver
  end

  def setup_tire
    Kinney::Clip.tire.create_elasticsearch_index      
    Kinney::Clip.tire.index.import Kinney::Clip.all
    Kinney::Person.tire.index.import Kinney::Person.all
    Kinney::Clip.tire.index.refresh
  end

  def teardown_tire
    Kinney::Clip.tire.index.delete
  end
end

# FROM: database_cleaner
# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  
  if File.exist? "/opt/firefox17/firefox"
    Selenium::WebDriver::Firefox.path= "/opt/firefox17/firefox"
  end
  # Stop ActiveRecord from wrapping tests in transactions
  #self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
