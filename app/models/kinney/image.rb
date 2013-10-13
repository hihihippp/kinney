module Kinney
  class Image < ActiveRecord::Base
    include Kinney::Concerns::Models::Image

    # This method should now be defined in the image override which is installed as part of the kinney:install generator
    # def external_url
    #   false
    # end

  end
end

# == Schema Information
#
# Table name: kinney_images
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  top_pick   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

