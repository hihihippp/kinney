require 'test_helper'

class MediaTypeTest < ActiveSupport::TestCase
  test "should be two media types audio and video loaded as seeds" do
    assert_equal 2, Kinney::MediaType.count
    assert Kinney::MediaType.find_by_name('video')
    assert Kinney::MediaType.find_by_name('audio')
    assert !Kinney::MediaType.find_by_name('alien morse code')
  end

  test "should be associated with clips" do
    video = kinney_media_types(:video)
    assert !video.clips.blank?
  end
end