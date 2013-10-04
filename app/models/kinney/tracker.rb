module Kinney
  class Tracker < ActiveRecord::Base
    serialize :seconds
  end
end