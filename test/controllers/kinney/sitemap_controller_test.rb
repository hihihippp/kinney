require 'test_helper'

class Kinney::SitemapControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, :format => :xml, :use_route => :kinney
    assert_response :success
    assert assigns(:people)
  end

end
