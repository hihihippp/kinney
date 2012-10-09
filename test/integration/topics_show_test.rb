require 'test_helper'

class TopicShowTest < ActionDispatch::IntegrationTest
  
  test "show duration near title" do
    visit(kinney.topic_path(kinney_topics(:roots)))
    assert page.has_selector?('h1', :text => 'Roots')
    assert page.has_content?('Growing Up in Edgecombe County')
    assert page.has_content?('0:44')
  end

  test "topics page should include full name" do
    visit(kinney.topic_path(kinney_topics(:roots)))
    assert page.has_content?('Edward Norris Tolson')
  end
  
end