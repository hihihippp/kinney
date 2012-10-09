require 'test_helper'

class PeopleShowTest < ActionDispatch::IntegrationTest
  setup do
    #Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  test 'shows person content' do
    visit(kinney.person_path(kinney_people(:tolson)))
    assert page.has_content?('Edward Norris Tolson')
    
    assert page.has_selector?('h2', :text => 'Years at State')
    assert page.has_content?('Class of 1963')
    assert page.has_content?('Student Body President 1962-1963')
    
    # video titles
    assert page.find_link('Growing Up in Edgecombe County')
    assert page.find_link('Mentors')
    
    assert page.has_content?('Tolson grew up in Edgecombe County.')
    
    assert page.has_selector?('h2', :text => 'Accomplishments')
    assert page.has_content?("Tolson's accomplishments.")
    
    assert page.has_selector?('h2', :text => 'Activities')
    assert page.has_content?("Tolson's activities.")
    
    assert page.has_selector?('h2', :text => 'Currently')
    assert page.has_content?("What Tolson is currently doing.")
    
    assert page.has_selector?('h2', :text => 'Citations')
    assert page.has_content?("This is a citation.")
  end
  
  test 'does not show headings for content fields when content is not present' do
    visit(kinney.person_path(kinney_people(:williams)))
    assert page.has_content?('William Williams')
    assert page.has_no_selector?('h2', :text => 'Years at State')
    assert page.has_no_selector?('h2', :text => 'Accomplishments')
    assert page.has_no_selector?('h2', :text => 'Images of William Williams')
    assert page.has_no_selector?('h2', :text => 'Activities')
    assert page.has_no_selector?('h2', :text => 'Currently')
    assert page.has_no_selector?('h2', :text => 'Citations')
  end

  test 'if there is only one image and it is a top pick then do not show the image section of the page' do
    visit(kinney.person_path(kinney_people(:atkins)))
    assert page.has_no_selector?('h2', :text => 'Images of Jonh Leslie Atkins')
  end
  
  test 'should give a link to other videos with the same person' do
    visit(kinney.person_path(kinney_people(:tolson)))
    assert page.has_selector?('#person_videos a', :text => 'Growing Up in Edgecombe County')
    page.find('#person_videos a', :text => 'Mentors').click
    assert page.has_selector?('h1', :text => 'Mentors')
  end
  
  test "should show a top pick image near the biography" do
    visit(kinney.person_path(kinney_people(:tolson)))
    assert page.find('#image_top_pick img')[:src].include?('si-ag1962-p408-tolson')
  end
  
  test "should not see the top pick image with the other images" do
    visit(kinney.person_path(kinney_people(:tolson)))
    page.all('#other_images img').each do |image|
      assert_false image[:src].include?('si-ag1962-p408-tolson')
    end
  end

  test "should show name_suffix if present" do
    visit(kinney.person_path(kinney_people(:atkins)))
    assert page.has_selector?('h1', :text => 'John Leslie Atkins, III')
  end
  
  test "should provide a link to a video as an image and make it a top pick" do
    visit(kinney.person_path(kinney_people(:tolson)))
    image_link = page.find('.thumbnail_video:first')[:href]
    assert_equal kinney.clip_path(kinney_clips(:tolson_roots)), image_link
  end

  test "should provide a link to other videos as text links" do 
    visit(kinney.person_path(kinney_people(:tolson)))
    assert page.has_selector?('#person_videos a', :text => 'Growing Up in Edgecombe County')
    assert page.has_selector?('#person_videos a', :text => '0:44')
    assert page.has_selector?('#person_videos a', :text => 'Mentors')
  end

  test "should display the information like description, interview date and time below video clip" do
    visit(kinney.clip_path(kinney_clips(:tolson_roots)))
    assert page.has_content?('This is a description of the Roots clip. Interview on June 4, 2011. (0:44)')
  end

  test "should display a map if the location the person grew up is known" do
    visit(kinney.person_path(kinney_people(:tolson)))
    assert page.has_selector?('#static_map')
    assert page.has_content?('Grew up in')
    assert page.has_content?('Edgecombe County, NC')    
  end

  test "should not display a map if the location the person grew up is not known" do
    visit(kinney.person_path(kinney_people(:atkins)))
    assert page.has_no_content?('Grew up in')
    assert page.has_no_selector?('#static_map')
  end

end