require 'test_helper'

class Kinney::PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about, :use_route => :kinney
    assert_response :success
  end

  test "should get giving" do
    get :giving, :use_route => :kinney
    assert_response :success
  end

  test "should get home" do
    get :home, :use_route => :kinney
    assert_response :success
  end

  test "home page should assign top_pick_clips" do
    get :home, :use_route => :kinney
    assert assigns(:top_pick_clips)
  end

  test "home page should assign featured clip" do
    get :home, :use_route => :kinney
    assert assigns(:featured_clip)
  end

end
