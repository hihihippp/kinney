module KinneyHelper

  def kinney_image_small(image, person=@person)
    # FIXME: Use the sample images.
    image_tag "http://placehold.it/150x150"
  end

  def kinney_image_modal(image, person)
    # FIXME: Use the sample images.
    image_tag "http://placehold.it/360x360"
  end

  def kinney_image_admin_show(image)
    # FIXME: Use the sample images.
    image_tag "http://placehold.it/360x360"
  end

  def kinney_image_title(image, person)
    person.full_name
  end

end