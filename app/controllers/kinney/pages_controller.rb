module Kinney
  class PagesController < KinneyController

    caches_action :about, :add_your_story, :home

    def about
      
    end

    def add_your_story
      @message = ContactMessage.new
    end

    def home
      @people = Person.with_images
      @featured_clip   = Clip.where(:featured => true).limit(1).first
      @top_pick_clips = Clip.top_picks
      @topics_with_clips = Topic.with_clips
      if @featured_clip.blank?
        @featured_clip = @top_pick_clips.pop
      end
      @person = @featured_clip.people.first if @featured_clip    
      # FIXME this could probably be optimized for finding just 8 random resources. But can it be done
      # in a non-database dependent way?
      # @people = Person.with_clips.where(Arel::Table.new(:people)[:id].not_in [@person.id]).shuffle[0..8]
    end
  end
end