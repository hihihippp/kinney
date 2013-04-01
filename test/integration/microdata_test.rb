require 'test_helper'

class MicrodataTest < ActionDispatch::IntegrationTest

  extend TestWithCassette
  
  test "clip show view should have microdata", :microdata do
    path = kinney.clip_path(kinney_clips(:tolson_roots))
    visit(path)
    items = Microdata::Document.new(page.body, path).extract_items
    item = items[0]
    assert_equal(['http://schema.org/VideoObject'], item.type)
    assert_equal(['http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots.mp4'], item.properties['contentUrl'])
    assert_equal(["T44S"], item.properties['duration'])
    assert_equal(["http://siskel.lib.ncsu.edu/SLI/tolson/tolson-roots/tolson-roots.png"], item.properties['thumbnailUrl'])
    assert item.properties['uploadDate']
    assert item.properties['image']
    assert item.properties['image'].first.include?('scrc.lib.ncsu.edu')
    assert_equal(["272"], item.properties['height'])
    assert_equal(["480"], item.properties['width'])
    assert_equal(["This is a description of the Roots clip. Interview on June  4, 2011. (0:44)"], item.properties['description'])
  end

  test "person show view should have microdata", :microdata do
    path = kinney.person_path(kinney_people(:tolson)) 
    visit(path)
    items = Microdata::Document.new(page.body, path).extract_items
    item = items[0]
    assert_equal(['http://schema.org/Person'], item.type)
    assert_equal(['Edward Norris Tolson'], item.properties['name'])
    assert_equal(2, item.properties['description'].length)
    assert item.properties['description'].include?("Norris Tolson grew up in Edgecombe County.")
    assert_equal(3, item.properties['image'].length)
    assert item.properties['image'].first.include?('scrc.lib.ncsu.edu')
    assert item.properties['alumniOf']
    assert_equal ['http://schema.org/EducationalOrganization'], item.properties['alumniOf'].first.type
    assert_equal(['North Carolina State University'], item.properties['alumniOf'].first.properties['name'])
  end

end