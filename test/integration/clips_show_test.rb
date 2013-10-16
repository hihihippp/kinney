require 'test_helper'

class ClipsShowTest < ActionDispatch::IntegrationTest

  extend TestWithCassette

  test "should show basic information about a clip", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('h1', :text => 'Tolson')
    assert page.has_selector?('h1', :text => 'Growing Up in Edgecombe County')
    assert page.has_selector?('video')
  end

  test "should have link to other videos by the same person", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#person_videos a', :text => 'Mentors')
  end

  test "should have link to profile", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#related_people a', :text => 'Edward Norris Tolson')
    assert page.has_selector?('#related_people a img')
  end

  test "should show the transcript", :clips_show do
    visit(kinney.clip_path(kinney_clips(:atkins_fire)))
    assert page.has_selector?('h2', :text => 'Transcript')
    assert page.has_content?('It was a frightening time')
  end

  test "should expand/collapse the transcript", :clips_show do
    browser_start
    # stubs out saving the tracker to work around a sqlite database locking issue
    Kinney::Tracker.any_instance.stubs(:save).returns(true)
    visit(kinney.clip_path(kinney_clips(:atkins_fire)))

    assert !page.all('#transcript_table tbody tr:nth-child(4)', visible: false).first.visible?

    page.find('#more_transcript_button').click
    assert page.all('#transcript_table tbody tr:nth-child(4)', visible: false).first.visible?
    assert page.has_content?('Hide most of the transcript')

    page.find('#hide_transcript_button').click
    assert !page.all('#transcript_table tbody tr:nth-child(4)', visible: false).first.visible?
    browser_end
  end

  test "should show other clips related by topic", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_selector?('#topic_clips a', :text => 'Applying to NC State')
  end

  test "should not see Video Topics section on page", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_no_content?('Video Topics')
  end

  test "should not see More videos on topics with link under video", :clips_show do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_no_content?('More videos on Roots')
  end

  test "should see button to download transcript as text or pdf" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_content?('Download Transcript')
    page.find('#download_transcript_group').click
    assert page.has_content?('PDF transcript')
    assert page.has_content?('Plain text transcript')
  end

end