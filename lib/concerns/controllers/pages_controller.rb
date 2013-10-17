module Kinney::Concerns::Controllers::PagesController
  extend ActiveSupport::Concern

  def about
  end

  def home
    # for the catch
    @people = Kinney::Person.with_images.with_top_pick_clip
    @top_pick_clips = Kinney::Clip.top_picks
    # featured clip
    @featured_clip   = Kinney::Clip.where(:featured => true).limit(1).first
    if @featured_clip.blank?
      @featured_clip = @top_pick_clips.pop
    end
    @person = @featured_clip.people.first if @featured_clip
    # explore topics
    @topics_with_clips = Kinney::Topic.with_clips
  end

end