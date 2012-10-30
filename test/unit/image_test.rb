require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "image can be associated with people" do
    image = kinney_images(:tolson1)
    image.people << kinney_people(:williams)
    assert image.valid?
  end
  
  test "image must have a filename" do
    assert Kinney::Image.new(:filename => 'filename').valid?
    assert_false Kinney::Image.new(:filename => nil).valid?
  end
  
  test "image filename must be unique" do
    assert_false Kinney::Image.new(:filename => kinney_images(:tolson1).filename).valid?
  end

  test "give a URL as the external_url" do
    assert_equal "http://d.lib.ncsu.edu/collections/catalog/si-ag1962-p100-tolson", kinney_images(:tolson1).external_url
  end

  test "should return a top pick image if a person has a top pick image" do    
    assert kinney_people(:tolson).image
  end

  test "should return an image of the person has at least one image even if it is not selected as a top_pick image" do
    person = kinney_people(:third_man)
    person.images = [kinney_images(:tolson1)]
    person.save
    assert person.image
  end
  
end
