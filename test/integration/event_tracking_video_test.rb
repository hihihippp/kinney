require 'test_helper'

class EventTrackingVideoTest < ActionDispatch::IntegrationTest
  setup do
    browser_start
  end
  teardown do
    browser_end
  end

  # FIXME: There may be a better way for these tests to run without the sleeps.
  # The sleep after initial page load is needed to allow the video to load in some way.
  # Then after we run the javascript we wait until there is something in the console.
  # Other interactions also require a sleep to wait for native video events to trigger.
  test "should trigger an event for a video playing" do
    skip unless ENV['VIDEO_JAVASCRIPT']
    visit kinney.clip_path(kinney_clips(:tolson_roots))
    sleep 1
    page.execute_script("$('video')[0].play();") # This initial play will trigger both a play and volumechange event
    wait_for_console_message
    page.execute_script("$('video')[0].pause();")
    page.execute_script("$('video')[0].play();")
    assert_equal "_trackEvent,Video,Play,tolson-roots", console_message
  end

  test "should trigger an event for a video that was paused" do
    skip unless ENV['VIDEO_JAVASCRIPT']
    visit kinney.clip_path(kinney_clips(:tolson_roots))
    sleep 1
    page.execute_script("$('video')[0].play();")
    wait_for_console_message
    page.execute_script("$('video')[0].pause();")
    assert_equal "_trackEvent,Video,Pause,tolson-roots", console_message
  end

  test "should trigger an event for a video that was seeked" do
    skip unless ENV['VIDEO_JAVASCRIPT']
    visit kinney.clip_path(kinney_clips(:tolson_roots))
    sleep 1
    page.execute_script("$('video')[0].play();")
    wait_for_console_message
    page.execute_script("$('video')[0].currentTime = 10;")
    sleep 1
    assert_equal "_trackEvent,Video,Seeked,tolson-roots", console_message
  end

  test "should trigger an event for a video that was ended" do
    skip unless ENV['VIDEO_JAVASCRIPT']
    visit kinney.clip_path(kinney_clips(:tolson_roots))
    sleep 1
    page.execute_script("$('video')[0].play();")
    wait_for_console_message
    page.execute_script("$('video')[0].currentTime = 47;")
    sleep 2
    assert_equal "_trackEvent,Video,Ended,tolson-roots", console_message
  end

  test "should trigger an event on volume change" do
    skip unless ENV['VIDEO_JAVASCRIPT']
    visit kinney.clip_path(kinney_clips(:tolson_roots))
    sleep 1
    page.execute_script("$('video')[0].volume = 0.3;")
    wait_for_console_message
    assert_equal "_trackEvent,Video,Volume,tolson-roots", console_message
  end

  # test "should trigger a tracking event for clicking on the full screen button" do
  #   skip
  #   visit kinney.clip_path(kinney_clips(:tolson_roots))
  #   sleep 1
  #   find('.mejs-fullscreen-button').click
  #   wait_for_console_message
  #   assert_equal "_trackEvent,Video,Full Screen,tolson-roots", console_message
  # end

  # test "should trigger a tracking event for clicking on the captions button" do
  #   skip
  #   visit kinney.clip_path(kinney_clips(:tolson_roots))
  #   sleep 1
  #   find('.mejs-captions-button', :visible => false).trigger(:mouseover)
  #   find('#mep_0_captions_en').click
  #   wait_for_console_message
  #   assert_equal "_trackEvent,Video,Captions,tolson-roots", console_message
  # end

  # test "should trigger a tracking event for clicking on the time rail" do
  #   skip
  #   visit kinney.clip_path(kinney_clips(:tolson_roots))
  #   sleep 1
  #   find('.mejs-time-rail').hover.click
  #   wait_for_console_message
  #   assert_equal "_trackEvent,Video,Time Rail,tolson-roots", console_message
  # end


end
