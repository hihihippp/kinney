require 'test_helper'

class Kinney::TrackerControllerTest < ActionController::TestCase
  # set_fixture_class :admin_users => Kinney::AdminUser
  # fixtures :admin_users

  include Devise::TestHelpers

  setup do
    
  end

  # test "should get track" do
  #   get :track
  #   assert_response :success
  # end

  test "should get analyze" do
    sign_in kinney_admin_users(:first)
    get :analyze, :use_route => :kinney, :video => 'tolson-roots'
    assert_response :success
  end

end
