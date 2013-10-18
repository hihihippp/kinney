require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest

  test "there should be a global nav" do
    visit(kinney.root_path)
    assert page.has_selector?('#global_nav')
  end

  test "there should be a Videos link in the global navigation" do
    visit(kinney.root_path)
    assert page.has_selector?('a', :text => 'Videos')
  end

  test "topics navigation in navbar should only include topics with clips" do
    visit(kinney.root_path)
    assert page.has_selector?('#global_nav #topics_nav li a', :text => 'Mentors')
    assert page.has_no_selector?('#global_nav #topics_nav li', :text => 'Academics')
  end

  test "topics navigation should highlight the current page in the dropdown menu if on a topic page" do
    visit(kinney.topic_path(kinney_topics(:mentors)))
    assert page.has_selector?('#topics_nav li.active a', :text => 'Mentors')
    assert page.has_selector?('#topics_nav li a', :text => 'Roots')
    assert page.has_no_selector?('#topics_nav li.active a', :text => 'Roots')
  end

  test "there should be a link to People in the global navigation" do
    visit(kinney.root_path)
    assert page.has_selector?('#global_nav ul li a', :text => 'People')
    page.find('#global_nav ul li a', :text => 'People').click
    assert page.current_url == kinney.people_url
  end

end