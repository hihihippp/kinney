module Kinney
  class ClipPerson < ActiveRecord::Base
    belongs_to :person
    belongs_to :clip
  end
end