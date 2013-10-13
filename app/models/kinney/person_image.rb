module Kinney
  class PersonImage < ActiveRecord::Base
    belongs_to :person
    belongs_to :image
  end
end

# == Schema Information
#
# Table name: kinney_person_images
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  image_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

