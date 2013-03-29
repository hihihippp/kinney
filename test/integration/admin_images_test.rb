require 'test_helper'

class AdminImagesTest < ActionDispatch::IntegrationTest
  extend TestWithCassette

  setup do
    browser_start
    admin_login
  end

  teardown do
    browser_end
  end
  
  test "user should not be able to create slug", :admin_images do
    visit(admin_kinney_images_path)
    click_link('New Kinney Image')
    fill_in 'Filename', :with => '000001'
    check 'Top Pick?'
  end
  
  test "user should see image for valid image on show page", :admin_images do
    visit admin_kinney_image_path(kinney_images(:tolson1))
    assert page.has_selector?("div img")
    assert page.find("div img")[:src].include?(kinney_images(:tolson1).filename)
  end
  
  test "user should see image for valid image on edit page", :admin_images do    
    visit edit_admin_kinney_image_path(kinney_images(:tolson1))
    assert page.find("#preview_image").has_selector?('img')
    assert page.find("#preview_image img")[:src].include?(kinney_images(:tolson1).filename)  
  end
  
  test "user should see image for valid image on new image page", :admin_images do
    visit new_admin_kinney_image_path
    fill_in 'Filename', :with => '0000001'
    assert page.find("#preview_image").has_selector?('img')
    assert page.find("#preview_image img")[:src].include?('0000001')    
  end

  test "user should see associated name for image on show view", :admin_images do
    visit admin_kinney_image_path(kinney_images(:tolson1))
    assert page.has_content?('Edward Norris Tolson')
  end

  test "user should see associated name for image on index view", :admin_images do
    visit admin_kinney_images_path
    assert page.has_content?('Edward Norris Tolson')
  end
  
end