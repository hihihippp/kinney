require 'test_helper'

class Kinney::ClipsControllerTest < ActionController::TestCase
  extend TestWithCassette

  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
    assert assigns(:people)
  end

  test_with_cassette "should get show", 'clips_controller' do
    get :show, :id => kinney_clips(:tolson_roots), :use_route => :kinney
    assert_response :success
    assert assigns(:clip)
  end

  test_with_cassette "should assign a webvtt variable", 'clips_controller' do
    get :show, :id => kinney_clips(:atkins_fire), :use_route => :kinney
    assert assigns(:webvtt)
    assert assigns(:webvtt).respond_to?(:cues)
  end

  test_with_cassette 'should assign title for a show view', 'clips_controller' do
    get :show, :id => kinney_clips(:tolson_roots), :use_route => :kinney
    assert_equal "This is a description of the Roots clip.", assigns(:meta_description)
  end

end
