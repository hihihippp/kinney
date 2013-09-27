require 'test_helper'

class AdminPeopleTest < ActionDispatch::IntegrationTest

  setup do
    admin_login
  end

  test "should have name suffix field" do
    visit(edit_admin_kinney_person_path(kinney_people(:atkins)))
    assert_equal 'III', page.find_field('kinney_person_name_suffix').value
  end

  test "should be able to submit for with location" do
    visit(edit_admin_kinney_person_path(kinney_people(:atkins)))
    fill_in "Location", :with => 'Durham, NC'
    click_button 'Update Person'
    assert page.has_content?('Person was successfully updated.')
  end

end