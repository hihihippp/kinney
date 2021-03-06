require 'test_helper'

class Kinney::ClipsControllerTest < ActionController::TestCase


  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
  end

  test "should get show" do
    get :show, :id => kinney_clips(:tolson_roots), :use_route => :kinney
    assert_response :success
    assert assigns(:clip)
  end

  test "should assign a webvtt variable" do
    get :show, :id => kinney_clips(:atkins_fire), :use_route => :kinney
    assert assigns(:webvtt)
    assert assigns(:webvtt).respond_to?(:cues)
  end

  test 'should assign title for a show view' do
    get :show, :id => kinney_clips(:tolson_roots), :use_route => :kinney
    assert_equal "This is a description of the Roots clip.", assigns(:meta_description)
  end

end
