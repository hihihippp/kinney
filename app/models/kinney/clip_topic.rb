module Kinney
  class ClipTopic < ActiveRecord::Base
    belongs_to :clip
    belongs_to :topic
    # attr_accessible :title, :body
  end
end