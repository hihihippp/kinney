module Kinney
  class KinneyController < ApplicationController
    helper Kinney::Engine.helpers

    before_filter :gather_topics_for_navigation

    def gather_topics_for_navigation
      @navigation_topics = Topic.with_clips
    end

    

  end
end