require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest



  setup do

  end

  test 'shows people' do
    visit(kinney.people_path)
    assert page.has_content?('People')
    assert page.has_content?('Tolson')
    assert page.has_content?('Atkins, III')
  end

  test 'links to show view for person with video' do
    visit(kinney.people_path)
    click_link('Edward Norris Tolson')
    assert current_path == kinney.person_path(kinney_people(:tolson))
  end

  test 'links to show view for person without video' do
    visit(kinney.people_path)
    page.click_link('William Williams')
    assert current_path == kinney.person_path(kinney_people(:williams))
  end

end