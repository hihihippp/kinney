require 'test_helper'

class Kinney::PeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, :use_route => :kinney
    assert_response :success
  end

  test "index page should have a title" do
    get :index, :use_route => :kinney
    assert_equal "People", assigns(:title)
    assert_equal "Past NC State student leaders.", assigns(:meta_description)
  end

  test "should get show" do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_response :success
  end

  test "show view should have a title" do
    get :show, :id => kinney_people(:tolson), :use_route => :kinney
    assert_equal "Edward Norris Tolson", assigns(:title)
    assert_equal "Norris Tolson grew up in Edgecombe County.", assigns(:meta_description)
  end

end
