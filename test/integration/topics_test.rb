require 'test_helper'

class TopicsTest < ActionDispatch::IntegrationTest

  test "topics page should list topics with clips" do
    visit(kinney.topics_path)
    assert page.find("#topics").has_content?('Mentors')
    assert page.find("#topics").has_no_content?('Academics')
  end
  
end