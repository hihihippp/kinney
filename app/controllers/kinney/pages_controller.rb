module Kinney
  class PagesController < KinneyController

    caches_action :about, :add_your_story, :home

    def about
      @title = 'About'
      @meta_description = 'About the Student Leadership Initiative'
    end

    def add_your_story
      @message = ContactMessage.new
      @title = 'Add Your Story'
      @meta_description = "Add your story of being an NC State student leader."
    end

    def home
      @featured_clip   = Clip.where(:featured => true).limit(1).first
      @top_pick_clips = Clip.top_picks
      if @featured_clip.blank?
        @featured_clip = @top_pick_clips.pop
      end
      @person = @featured_clip.people.first    
      @meta_description = "Bringing the evolving history of the student experience at NC State to life through video and audio oral histories."
      # FIXME this could probably be optimized for finding just 8 random resources. But can it be done
      # in a non-database dependent way?
      # @people = Person.with_clips.where(Arel::Table.new(:people)[:id].not_in [@person.id]).shuffle[0..8]
    end
  end
end