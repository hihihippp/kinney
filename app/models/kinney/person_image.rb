module Kinney
  class PersonImage < ActiveRecord::Base
    belongs_to :person
    belongs_to :image
  end
end