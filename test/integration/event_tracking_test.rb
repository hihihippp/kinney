require 'test_helper'

class EventTrackingTest < ActionDispatch::IntegrationTest
  setup do
    browser_start
  end
  teardown do
    browser_end
  end

  test "should trigger an event for clicking on the navbar title" do
    visit(root_path)
    find("#global_nav .navbar-brand").click
    assert_equal "_trackEvent,kinney_pages_home,global_nav,Kinney", console_message
  end


end
