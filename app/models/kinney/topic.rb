module Kinney
  class Topic < ActiveRecord::Base
    include Kinney::Concerns::Models::Topic
  end
end

# == Schema Information
#
# Table name: kinney_topics
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#  description :text
#

