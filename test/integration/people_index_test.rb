require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest

  extend TestWithCassette

  setup do

  end

  test 'shows people', :people_index do
    visit(kinney.people_path)
    assert page.has_content?('People')
    assert page.has_content?('Tolson')
    assert page.has_content?('1963')
    assert page.has_content?('Atkins, III')
  end

  test 'links to show view for person with video', :people_index do
    visit(kinney.people_path)
    click_link('Edward Norris Tolson')
    assert current_path == kinney.person_path(kinney_people(:tolson))
  end

  test 'links to show view for person without video', :people_index do
    visit(kinney.people_path)
    page.find('#people_no_clips').click_link('William Williams')
    assert current_path == kinney.person_path(kinney_people(:williams))
  end

end