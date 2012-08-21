module KinneyHelper  
  
  def kinney_image_small(image, person=@person)
    if defined?(Djatoka)
      djatoka_square_image_tag image.filename, :scale => 150, :itemprop => :image, :alt => person.full_name
    else
      image_tag "http://placehold.it/150x150"
    end
  end

  def kinney_image_modal(image, person)
    if defined?(Djatoka)
      djatoka_image_tag image.filename, :scale => 360, :height => 360, :alt => person.full_name
    else
      image_tag "http://placehold.it/360x360"
    end
  end

  def kinney_image_admin_show(image)
    if defined?(Djatoka)
      djatoka_image_tag image.filename, :scale => 250
    else
      image_tag "http://placehold.it/360x360"
    end
  end

  def kinney_image_title(image, person)
    person.full_name
  end

end