module Kinney
  class Image < ActiveRecord::Base
    include Kinney::Concerns::Models::Image

    # TODO: override this with the URL for how to see the image on an external site
    def external_url
      File.join('http://example.com/', filename)
    end

  end
end