require 'test_helper'

class AdminTopicsTest < ActionDispatch::IntegrationTest
  
  setup do
    admin_login
  end
  
  test "user should not be able to create slug" do
    visit(admin_kinney_topics_path)
    click_link('New Kinney Topic')
    assert page.has_no_content?('Slug')
  end
  
end