module KinneyHelper

  def kinney_image_small(image, person=@person)
    # FIXME: Have a better fallback than a placeholder image.
    image_tag "http://placehold.it/150x150"
  end

  def kinney_image_modal(image, person)
    # FIXME: Have a better fallback than a placeholder image.
    image_tag "http://placehold.it/360x360"
  end

  def kinney_image_admin_show(image)
    # FIXME: Have a better fallback than a placeholder image.
    image_tag "http://placehold.it/360x360"
  end

  def kinney_image_title(image, person)
    person.full_name
  end

end