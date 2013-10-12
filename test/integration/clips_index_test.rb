require 'test_helper'

class ClipsIndexTest < ActionDispatch::IntegrationTest

  extend TestWithCassette

  test "clip index page should list all of the people with videos and the titles of their videos", :clips_index do
    visit(kinney.clips_path)
    assert page.has_content?('Tolson')
    assert page.has_content?('Growing Up in Edgecombe County')
    assert page.has_content?('Mentors')
    assert page.has_content?('Atkins')
    assert page.has_content?('Pullen Fire')
  end

  test "clip index page should list the name_suffix of a person", :clips_index do
    visit(kinney.clips_path)
    assert page.has_content?('John Leslie Atkins, III')
  end

  test "clicking on a video thumbnail should go to a video clip", :clips_index do
    visit(kinney.clips_path)
    page.first('.thumbnail_video').click
    assert page.has_selector?('body.kinney_clips video')
  end

  test "the first text link should be the same as the video thumbnail link", :clips_index do
    visit(kinney.clips_path)
    atkins_section = page.first('#clip_profiles div')
    image_link = atkins_section.find('.thumbnail_video')[:href]
    assert_equal kinney.clip_path(kinney_clips(:atkins_fire)), image_link
    first_list_link = atkins_section.first('a')[:href]
    assert_equal kinney.clip_path(kinney_clips(:atkins_fire)), first_list_link
    assert first_list_link != atkins_section.all('a').last[:href]
  end

end