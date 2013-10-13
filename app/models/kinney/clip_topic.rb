module Kinney
  class ClipTopic < ActiveRecord::Base
    belongs_to :clip
    belongs_to :topic
  end
end

# == Schema Information
#
# Table name: kinney_clip_topics
#
#  id         :integer          not null, primary key
#  clip_id    :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

