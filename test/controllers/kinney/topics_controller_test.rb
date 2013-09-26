require 'test_helper'

class Kinney::TopicsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, :id => kinney_topics(:roots), :use_route => :kinney
    assert_response :success
    assert assigns(:topic)
  end
  
  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
    assert assigns(:topics)
  end

  test "show view should have title" do
    get :show, :id => kinney_topics(:roots), :use_route => :kinney
    assert_equal "Roots description", assigns(:meta_description)
  end
  
end
