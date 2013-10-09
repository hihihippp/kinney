module Kinney
  class Tracker < ActiveRecord::Base
    serialize :seconds, Array
  end
end