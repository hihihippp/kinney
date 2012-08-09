module Kinney
  class VideoSession < ActiveRecord::Base
    attr_accessible :seconds, :session, :site, :time, :uuid, :video
    serialize :seconds
  end
end