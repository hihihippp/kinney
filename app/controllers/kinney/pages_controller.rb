module Kinney
  class PagesController < KinneyController

    caches_action :about, :home

    def about
      
    end

    def home
      # for the catch
      @people = Person.with_images.with_top_pick_clip
      @top_pick_clips = Clip.top_picks
      # featured clip
      @featured_clip   = Clip.where(:featured => true).limit(1).first
      if @featured_clip.blank?
        @featured_clip = @top_pick_clips.pop
      end
      @person = @featured_clip.people.first if @featured_clip    
      # explore topics
      @topics_with_clips = Topic.with_clips
    end
  end
end