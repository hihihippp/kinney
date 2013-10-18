module Kinney
  module ImageHelper

    def base_image_path
      '/photos/'
    end

    def image_path(image)
      File.join(base_image_path, image.filename + '.jpg')
    end

    def kinney_image_small(image, person=@person)
      # FIXME: Use the sample images.
      image_tag image_path(image), itemprop: :image, style: 'height: 150px;'
    end

    def kinney_image_modal(image, person)
      # FIXME: Use the sample images.
      image_tag image_path(image), style: 'height: 300px;'
    end

    def kinney_image_admin_show(image)
      # FIXME: Use the sample images.
      image_tag image_path(image)
    end

    def kinney_image_title(image, person)
      person.full_name
    end
  end
end