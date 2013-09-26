require 'test_helper'

class Kinney::AdminClipsControllerTest < ActionController::TestCase
  # set_fixture_class :admin_users => Kinney::AdminUser
  # fixtures :admin_users

  include Devise::TestHelpers

  setup do
    @controller = ::Admin::KinneyClipsController.new
  end

  # test "should get track" do
  #   get :track
  #   assert_response :success
  # end

  test "should get analyze" do
    sign_in kinney_admin_users(:first)
    get :analyze_tracker, :use_route => :kinney, :id => 'tolson-roots'
    assert_response :success
  end

end
