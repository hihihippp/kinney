require 'test_helper'

class Kinney::SearchControllerTest < ActionController::TestCase

  setup do
    setup_tire
  end

  teardown do
    teardown_tire
  end

  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
  end

  test "should assign clips and people on index page with no query" do
    get :index, :use_route => :kinney
    assert assigns(:clips)    
    assert assigns(:people)
  end

  test "should assign fallbacks for clips when no matching query" do
    get :index, :q => 'biography', :use_route => :kinney
    assert_equal 'Atkins', assigns(:people).first.last_name
    assert_equal 1, assigns(:people).size
    assert_equal 'Growing Up in Edgecombe County', assigns(:clips).first.title
    assert_equal 2, assigns(:clips).size #top picks
  end

  test "should assign fallbacks for people when no matching query" do
    get :index, :q => 'intrigue', :use_route => :kinney
    assert assigns(:people)
    assert 'Pullen Fire', assigns(:clips).first.title
  end

end
