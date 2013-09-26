module Kinney
  class ClipTopic < ActiveRecord::Base
    belongs_to :clip
    belongs_to :topic
  end
end