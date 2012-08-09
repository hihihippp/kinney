require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest

  setup do
    setup_tire
  end

  teardown do
    teardown_tire
  end

  test "for the search 'atkins' should show one person and a topic pick clip" do
    visit(kinney.search_path(:q=>'biography'))
    assert page.has_content?('John Leslie Atkins')
    assert page.has_no_content?('There is no current search')
    assert page.has_no_content?('No people profiles matched your search')
  end

  test "for the search 'intrigue' should show one clip and a people fallback" do
    visit(kinney.search_path(:q => 'intrigue'))
    assert page.has_content?('No people profiles matched your search')
    assert page.has_content?('Edward Norris Tolson')
    assert page.has_content?('Pullen Fire')
  end

  test "for search 'atkins' should find the clips and one person" do
    visit(kinney.search_path(:q => 'atkins'))
    assert page.has_content?('Pullen Fire')
    assert page.has_content?('Applying to NC State')
    assert page.has_content?('John Leslie Atkins, III')
    assert page.has_no_content?('No people profiles matched your search')
    assert page.has_no_content?('No clips matched your search')
  end

  test "search page should have a clips and people id" do
    visit(kinney.search_path)
    assert page.has_selector?('#clips')
    assert page.has_selector?('#people')
  end

end