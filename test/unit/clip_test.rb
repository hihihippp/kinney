require 'test_helper'

class ClipTest < ActiveSupport::TestCase
  
  test "should create title and filename" do
    clip = Kinney::Clip.new(:title => 'Title', :filename => 'filename')
    assert_equal "Title filename", clip.title_and_filename
  end
  
  test "clip with multiple topics should provide list of topic names" do
    clip = Kinney::Clip.new(:title => 'Title', :filename => 'filename')
    clip.topics = Kinney::Topic.all
    assert clip.topic_names.include?('Roots')
    assert clip.topic_names.include?('Mentors')
    assert_instance_of Array, clip.topic_names
  end
  
  # The next few tests have an interaction with the default_scope so we
  # have to reload the clip in order for the ordering to match. Otherwise
  # the query does not go to the database and there is no ordering done.
  test "clip should return people names with title" do
    clip = kinney_clips(:tolson_roots)
    assert_equal "Tolson: Growing Up in Edgecombe County", clip.people_with_title 
    clip.people << kinney_people(:williams)
    clip.save
    clip.reload
    assert_equal "Tolson and Williams: Growing Up in Edgecombe County", clip.people_with_title
    clip.people << kinney_people(:third_man)
    clip.save
    clip.reload
    assert_equal "Man, Tolson, and Williams: Growing Up in Edgecombe County", clip.people_with_title
  end
  
  test "clip should return people names" do
    clip = kinney_clips(:tolson_roots)
    assert_equal "Tolson", clip.people_names
    clip.people << kinney_people(:williams)
    clip.save
    clip.reload
    assert_equal "Tolson and Williams", clip.people_names
    clip.people << kinney_people(:third_man)
    clip.save
    clip.reload
    assert_equal "Man, Tolson, and Williams", clip.people_names
  end

  test "clip should return full people names" do 
    clip = kinney_clips(:tolson_roots)
    assert_equal "Edward Norris Tolson", clip.full_people_names
    clip.people << kinney_people(:williams)
    clip.save
    clip.reload
    assert_equal "Edward Norris Tolson and William Williams", clip.full_people_names
    clip.people << kinney_people(:third_man)
    clip.save
    clip.reload
    assert_equal "Third Man, Edward Norris Tolson, and William Williams", clip.full_people_names
  end
  
  test "clip should return the full URL for the poster image" do
    assert_equal "http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots.png",
      kinney_clips(:tolson_roots).png
  end
  
  test "clip should return the full URL for an MP4" do
    assert_equal "http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots.mp4",
      kinney_clips(:tolson_roots).mp4
  end
  
  test "clip should return the full URL for an WebM" do
    assert_equal "http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots.webm",
      kinney_clips(:tolson_roots).webm
  end
  
  # test "clip should return video switcher parameters" do
  #   vsparams = kinney_clips(:tolson_roots).video_switcher_params
  #   assert_equal 'video_play_button', vsparams[:class]
  #   assert_equal 'http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots', vsparams[:'data-video-url']
    
  #   data_video_topics = JSON.parse(vsparams[:'data-video-topics'])
  #   assert_equal "Roots", data_video_topics[0]["name"]
  #   assert data_video_topics[0]["href"].include?('/topics/')
    
  #   assert vsparams[:'data-video-quotes'].include?( %Q{<p>Quotes on Tolson's Roots.</p>} )
  #   data_video_profiles = JSON.parse(vsparams[:'data-video-profiles'])
  #   assert_equal "Edward Norris Tolson", data_video_profiles[0]["full_name"]
  #   assert_equal "<p>Norris Tolson grew up in Edgecombe County.</p>", data_video_profiles[0]["short_bio"]
  #   assert_equal "Tolson", data_video_profiles[0]["last_name"]
  #   assert data_video_profiles[0]['person_href']
    
  # end
  
  test "should return a duration in ISO8601 format" do
    clip = kinney_clips(:tolson_roots)
    assert_equal "T44S",    clip.duration_iso8601
    clip.duration = 62
    assert_equal "T1M2S",   clip.duration_iso8601
    clip.duration = 3600
    assert_equal 'T1H',     clip.duration_iso8601
    clip.duration = 3662
    assert_equal 'T1H1M2S', clip.duration_iso8601
  end

  test "should return a pretty formatted clip duration" do
    clip = kinney_clips(:tolson_roots)
    assert_equal '0:44', clip.duration_pretty
    clip.duration = 62
    assert_equal "1:02", clip.duration_pretty
    # clip.duration = 3600
    # assert_equal '01:00:00', clip.duration_pretty
    # clip.duration = 3662
    # assert_equal '01:01:02', clip.duration_pretty
  end
  
  test "a valid clip should be valid" do
    assert kinney_clips(:tolson_roots).valid?
  end
  
  test "a clip without a filename is invalid" do
    clip = kinney_clips(:tolson_roots)
    clip.filename = nil
    assert_false clip.valid?
  end
  test "a clip without a duration is invalid" do
    clip = kinney_clips(:tolson_roots)
    clip.duration = nil
    assert_false clip.valid?
  end
  test "a clip without a title is invalid" do
    clip = kinney_clips(:tolson_roots)
    clip.title = nil
    assert_false clip.valid?
  end
  test "a clip without a description is invalid" do
    clip = kinney_clips(:tolson_roots)
    clip.description = nil
    assert_false clip.valid?
  end
  test "a clip without a interview date is invalid" do
    clip = kinney_clips(:tolson_roots)
    clip.interview_date = nil
    assert_false clip.valid?
  end
  test "a clip should have a unique filename" do
    clip = kinney_clips(:tolson_roots).dup
    assert_false clip.valid?
  end

  test "clip without an associated person is invalid" do
    clip = Kinney::Clip.new(:title => 'Title', :filename => 'filename',  
      :duration => 44, :interview_date => Date.new, :description => 'description')
    clip.topics = [kinney_topics(:mentors)]
    assert_false clip.valid?
    clip.people = [kinney_people(:tolson)]
    assert clip.valid?
  end

  test "clip without an associated topic is invalid" do
    clip = Kinney::Clip.new(:title => 'Title', :filename => 'filename', 
      :duration => 44, :interview_date => Date.new, :description => 'description')
    clip.people = [kinney_people(:tolson)]
    assert_false clip.valid?
    clip.topics = [kinney_topics(:mentors)]
    assert clip.valid?
  end

  test "clip should return related topic clips" do
    clip = kinney_clips(:tolson_roots)
    related_clips = clip.related_topic_clips
    assert related_clips.include?(kinney_clips(:atkins_roots))
    assert !related_clips.include?(kinney_clips(:tolson_roots))
  end

  test "should have a scope to return top_pick clips" do
    clips = Kinney::Clip.top_picks
    assert clips.size > 1
    assert clips.first.top_pick
  end
  
end
