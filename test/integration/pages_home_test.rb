require 'test_helper'

class PagesHomeTest < ActionDispatch::IntegrationTest

  test "topics navigation on home page should only include topics with clips" do
    visit(kinney.root_path)
    assert page.has_selector?('#topics a', :text => 'Mentors')
    assert page.has_no_selector?('#topics a', :text => 'Academics')
  end

  test "home page should have a featured clip" do
    visit(kinney.root_path)
    assert page.has_selector?('#featured_clip', :text => 'Applying to NC State')
  end

end