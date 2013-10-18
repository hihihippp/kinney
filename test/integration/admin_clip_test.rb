require 'test_helper'

class AdminClipTest < ActionDispatch::IntegrationTest

  setup do
    browser_start
    admin_login
  end

  teardown do
    browser_end
  end

  test "admin user can create new clip" do
    visit(admin_kinney_clips_path)
    click_link('New Kinney Clip')
    assert page.has_content?('New Kinney Clip')
  end

  test "adding duration to the form when filename entered" do
    skip
    visit(new_admin_kinney_clip_path)
    assert page.find_field('kinney_clip_duration')
    assert page.find_field('kinney_clip_duration').value.empty?
    fill_in 'Filename', :with => 'tolson-roots'
    page.find_field('kinney_clip_filename').trigger('focus')
    wait_for_ajax
    sleep 2 # FIXME: instead loop until the value is present using a timeout
    assert_equal '13', page.find_field('kinney_clip_duration').value
  end

  test "add a description for a clip" do
    visit(new_admin_kinney_clip_path)
    assert page.find_field('kinney_clip_description')
    fill_in 'Description', :with => 'This is a description of a new clip.'
  end

  test "display whether there is a VTT file for a clip" do
    skip
    # How to use something like VCR for ajax requests?
    # visit(new_admin_kinney_clip_path)
    # fill_in 'Filename', :with => 'atkins-campuslife_fire'
    # page.execute_script("$('#kinney_clip_filename').trigger('focus')") # to make sure focus is triggered
    # assert page.has_content?('WEBVTT Found')
    # fill_in 'Filename', :with => 'some-garbage'
    # assert page.has_content?('WEBVTT Not Found')
  end

  test "do not allow submission of clip if there is no webvtt file" do
    skip # Need to make this configurable
    visit(new_admin_kinney_clip_path)
    assert page.has_selector?('#kinney_clip_submit_action input[disabled="disabled"]')
    fill_in 'Filename', :with => 'atkins-campuslife_fire'
    page.execute_script("$('#kinney_clip_filename').trigger('focus')") # to make sure focus is triggered
    assert page.has_no_selector?("#kinney_clip_submit[disabled='disabled']")
    fill_in 'Filename', :with => 'atkins-campuslife'
    assert page.has_selector?("#kinney_clip_submit_action input[disabled='disabled']")
  end

end
