module Kinney
  class ClipPerson < ActiveRecord::Base
    belongs_to :person
    belongs_to :clip
  end
end

# == Schema Information
#
# Table name: kinney_clip_people
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  clip_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

