module Kinney
  class Image < ActiveRecord::Base
    include Kinney::Concerns::Models::Image

    # This method should now be defined in the image override which is installed as part of the kinney:install generator
    # def external_url
    #   false
    # end

  end
end