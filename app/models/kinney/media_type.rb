module Kinney
  class MediaType < ActiveRecord::Base
    include Kinney::Concerns::Models::MediaType
  end
end

# == Schema Information
#
# Table name: kinney_media_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

