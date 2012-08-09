require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test 'should validate the presence of topic name' do
    assert Kinney::Topic.new(:name => 'Name', :description => 'Desc').valid?
    assert_false Kinney::Topic.new(:description => 'Desc').valid?
  end
  
  test 'should validate uniqueness of name' do
    assert_false Kinney::Topic.new(:name => 'Roots', :description => 'Desc').valid?
  end

  test 'should validate presence of description' do
    assert_false Kinney::Topic.new(:name => 'Name').valid?
  end
  
  test "topics should be ordered by name by default" do
    zebras = Kinney::Topic.create :name => 'Zebras', :description => 'desc'
    apples = Kinney::Topic.create :name => 'Apples', :description => 'desc'
    assert Kinney::Topic.all.index(apples) < Kinney::Topic.all.index(zebras)
  end
  
  test "only topics with clips should be returned by default" do
    assert Kinney::Topic.with_clips.include?(kinney_topics(:mentors))
    assert_false Kinney::Topic.with_clips.include?(kinney_topics(:academics))
  end
  
end
