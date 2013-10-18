require 'test_helper'

class Kinney::PeopleControllerTest < ActionController::TestCase

  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
  end

  test "should get show" do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_response :success
  end

  test "show view should have a title" do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_equal "Norris Tolson grew up in Edgecombe County.", assigns(:meta_description)
  end

end
