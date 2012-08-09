require 'test_helper'

class Kinney::PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about, :use_route => :kinney
    assert_response :success
  end

  test "about page should have a title" do
    get :about, :use_route => :kinney
    assert_equal "About", assigns(:title)
    assert_equal "About the Student Leadership Initiative", assigns(:meta_description)
  end

  test "should get add_your_story" do
    get :add_your_story, :use_route => :kinney
    assert_response :success
  end

  test "add_your_story page should have a title" do
    get :add_your_story, :use_route => :kinney
    assert_equal "Add Your Story", assigns(:title)
    assert_equal "Add your story of being an NC State student leader.", assigns(:meta_description)
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

  test "home page should have the default title" do
    get :home, :use_route => :kinney
    assert_nil assigns(:title)
    assert_equal "Bringing the evolving history of the student experience at NC State to life through video and audio oral histories.",
      assigns(:meta_description)
  end

end
