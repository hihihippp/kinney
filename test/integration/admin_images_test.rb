require 'test_helper'

class AdminImagesTest < ActionDispatch::IntegrationTest


  setup do
    browser_start
    admin_login
  end

  teardown do
    browser_end
  end

  test "user should see image for valid image on show page" do
    visit admin_kinney_image_path(kinney_images(:tolson1))
    assert page.has_selector?("div img")
    assert page.find("div img")[:src].include?(kinney_images(:tolson1).filename)
  end

  test "user should see image for valid image on edit page" do
    visit edit_admin_kinney_image_path(kinney_images(:tolson1))
    assert page.find("#preview_image").has_selector?('img')
    assert page.find("#preview_image img")[:src].include?(kinney_images(:tolson1).filename)
  end

  test "user should see image for valid image on new image page" do
    visit new_admin_kinney_image_path
    fill_in 'Filename', :with => '0004685'
    assert page.find("#preview_image").has_selector?('img')
    assert page.find("#preview_image img")[:src].include?('0004685')
  end

  test "user should see associated name for image on show view" do
    visit admin_kinney_image_path(kinney_images(:tolson1))
    assert page.has_content?('Edward Norris Tolson')
  end

  test "user should see associated name for image on index view" do
    visit admin_kinney_images_path
    assert page.has_content?('Edward Norris Tolson')
  end

end