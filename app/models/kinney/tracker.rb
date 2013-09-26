module Kinney
  class Tracker < ActiveRecord::Base
    # attr_accessible :seconds, :session, :sessioned, :site, :time, :uuid, :video
    serialize :seconds
  end
end