require 'test_helper'

class ClipsShowTest < ActionDispatch::IntegrationTest
  test "should show basic information about a clip" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('h1', :text => 'Tolson')
    assert page.has_selector?('h1', :text => 'Growing Up in Edgecombe County')
    assert page.has_selector?('video')
  end

  test "should have link to other videos by the same person" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#person_videos a', :text => 'Mentors')
  end

  test "should have link to profile" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#related_people a', :text => 'Edward Norris Tolson')
    assert page.has_selector?('#related_people a img')
  end

  test "should show the transcript" do
    visit(kinney.clip_path(kinney_clips(:atkins_fire)))
    assert page.has_selector?('h2', :text => 'Transcript')
    assert page.has_content?('It was a frightening time')
  end

  test "should expand/collapse the transcript" do
    browser_start
    visit(kinney.clip_path(kinney_clips(:atkins_fire)))
    assert_false page.find('#transcript_table tbody tr:nth-child(4)').visible?

    page.find('#more_transcript_button').click
    assert page.find('#transcript_table tbody tr:nth-child(4)').visible?
    assert page.has_content?('Hide most of the transcript')

    page.find('#hide_transcript_button').click
    assert_false page.find('#transcript_table tbody tr:nth-child(4)').visible?
    browser_end
  end

  test "should show other clips related by topic" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#topic_clips a', :text => 'Applying to NC State')
  end

  test "should not see Video Topics section on page" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_no_content?('Video Topics')
  end

  test "should not see More videos on topics with link under video" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_no_content?('More videos on Roots')
  end

end