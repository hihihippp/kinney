# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'capybara/rails'
require 'capybara/webkit'
require 'mocha/setup'
# require 'selenium-webdriver'
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
    Capybara.current_driver = :webkit
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

  # if File.exist? "/opt/firefox17/firefox"
  #   Selenium::WebDriver::Firefox.path= "/opt/firefox17/firefox"
  # end

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end

  def console_message
    page.driver.console_messages.last[:message]
  end

  def console_messages
    page.driver.console_messages
  end

  def wait_for_console_message(seconds=10)
    Timeout.timeout(seconds) do
      sleep(0.1) until !page.driver.console_messages.blank?
    end
  end
end

if ENV['FASTFAIL']
  # On failure/error, print stack trace and exit.
  module MiniTest
    class Unit
      def puke_with_immediate_feedback(klass, meth, e)
        # Workaround for minitest weirdness: When puke gets called *again* after
        # @exiting has been set to true down below, exit immediately so we don't
        # get an extra SystemExit stack trace.  Exiting without exclamation mark
        # doesn't get the non-zero exit code through, but all teardown handlers
        # have been run at this point, so it's OK to use a hard exit here.
        exit! 1 if @exiting_from_puke
        result = puke_without_immediate_feedback(klass, meth, e)
        unless e.is_a?(MiniTest::Skip)
          # Failure or Error, so print the report we just wrote and exit.
          puts "\n#{@report.pop}\n"
          @exiting_from_puke = true
          exit 1
        end
        result
      end
      alias_method_chain :puke, :immediate_feedback
    end
  end
end
