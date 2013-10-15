require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save a person without a last name" do
    person = Kinney::Person.new(:first_name => 'Lastname')
    assert !person.save
  end

  test "should not save a duplicate name" do
    person = Kinney::Person.new(:first_name => 'Edward', :last_name => 'Tolson')
    assert !person.save
  end

  test "should save if only the last name is a duplicate" do
    person = Kinney::Person.new(:first_name => 'John', :last_name => 'Tolson')
    assert person.save
  end

  test "should create a label based on first and last names" do
    assert_equal "Tolson, Edward", kinney_people(:tolson).to_label
  end

  test "should create a full name from first, middle and last names" do
    assert_equal "Edward Norris Tolson", kinney_people(:tolson).full_name
  end

  test "should create a full name that includes name_suffix" do
    assert_equal "John Leslie Atkins, III", kinney_people(:atkins).full_name
  end

  test "should create a short bio with tags" do
    assert_equal "<p>Norris Tolson grew up in Edgecombe County.</p>", kinney_people(:tolson).short_bio
  end

  test "should be able to have a name_suffix" do
    atkins = kinney_people(:atkins)
    atkins.name_suffix = "III"
    assert atkins.valid?
  end

  test "people should be ordered by last name by default" do
    zebra = Kinney::Person.create :last_name => 'Zebra'
    apple = Kinney::Person.create :last_name => 'Apple'
    assert Kinney::Person.all.find_index(apple) < Kinney::Person.all.find_index(zebra)
  end

  test "should provide the top pick image" do
    assert_equal kinney_images(:tolson2), kinney_people(:tolson).image
  end

  test "should return only people with a top pick video" do
    people = Kinney::Person.with_top_pick_clip
    assert_equal 2, people.length
  end

  test "should return a top_pick clip for a person" do
    atkins = kinney_people(:atkins)
    clip = atkins.top_pick_clip
    assert_equal kinney_clips(:atkins_fire), clip
  end

  test "should return people with images" do
    people = Kinney::Person.with_images
    assert_equal 3, people.length
  end

  test "should return people without images" do
    people = Kinney::Person.without_images
    assert_equal 5, people.length
  end

end
