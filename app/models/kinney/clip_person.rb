module Kinney
  class ClipPerson < ActiveRecord::Base
    belongs_to :person
    belongs_to :clip
    # attr_accessible :title, :body
  end
end