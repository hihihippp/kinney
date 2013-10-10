module Kinney
  class Topic < ActiveRecord::Base
    include Kinney::Concerns::Models::Topic
  end
end
