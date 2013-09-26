require 'test_helper'

class Kinney::PeopleControllerTest < ActionController::TestCase
  extend TestWithCassette

  test "should get index", :people_controller do
    get :index, :use_route => :kinney
    assert_response :success
  end

  test "should get show", :people_controller do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_response :success
  end

  test "show view should have a title", :people_controller do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_equal "Norris Tolson grew up in Edgecombe County.", assigns(:meta_description)
  end

end
