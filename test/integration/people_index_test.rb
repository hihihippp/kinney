require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest
  setup do
    
  end

  test 'shows people' do
    visit(kinney.people_path)
    assert page.has_content?('People')
    assert page.has_content?('Tolson')
    assert page.has_content?('1963')
    assert page.has_content?('Atkins, III')
  end
  
  test 'links to show view for person with video' do
    visit(kinney.people_path)
    click_link('Edward Norris Tolson')
    assert current_path == kinney.person_path(kinney_people(:tolson))
  end
  
  test 'links to show view for person without video' do
    visit(kinney.people_path)
    page.find('#people_no_clips').click_link('William Williams')
    assert current_path == kinney.person_path(kinney_people(:williams))
  end
  
  test 'sort profile images' do
    browser_start
    visit(kinney.people_path)
    assert page.find('.thumbnails li:first').has_content?('Atkins')
    click_link('sort_graduating_class')
    assert page.find('.thumbnails li:first').has_content?('Friday')
    assert page.find('.thumbnails li:last').has_content?('Atkins')
    click_link('sort_last_name')
    assert page.find('.thumbnails li:first').has_content?('Atkins')
    browser_end
  end
  
end