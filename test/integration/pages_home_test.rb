require 'test_helper'

class PagesHomeTest < ActionDispatch::IntegrationTest
  
  test "topics navigation on home page should only include topics with clips" do
    visit(kinney.root_path)
    assert page.has_selector?('#topics li', :text => 'Mentors')
    assert page.has_no_selector?('#topics li', :text => 'Academics')
  end

  test "home page should have link to More Video" do
    visit(kinney.root_path)
    assert page.has_selector?('a', :text => "Video")
    assert page.has_selector?('#more_clips')
  end

  test "home page should have a featured clip" do
    visit(kinney.root_path)
    assert page.has_selector?('#featured_clip', :text => 'Applying to NC State')
  end
  
end