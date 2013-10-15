module Kinney
  class InterviewerPerson < ActiveRecord::Base
    belongs_to :clip
    belongs_to :person
  end
end
