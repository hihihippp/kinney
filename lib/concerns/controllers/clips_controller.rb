module Kinney::Concerns::Controllers::ClipsController
  extend ActiveSupport::Concern

  included do
  end

  def index
    @people = Kinney::Person.with_clips
    @clips = Kinney::Clip.all
  end

  def show
    @clip = Kinney::Clip.friendly.includes(:people).find(params[:id])
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the clip_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if !@clip.slug.blank? and params[:id] != @clip.slug
      return redirect_to @clip, :status => :moved_permanently
    end
    assign_webvtt
    # find people with clips associated with this clip
    clip_people_ids = @clip.people.pluck(:person_id)
    # FIXME this could probably be optimized for finding just 8 random resources. But can it be done
    # in a non-database dependent way?
    @people = Kinney::Person.with_clips.where(Arel::Table.new(:kinney_people)[:id].not_in clip_people_ids).shuffle[0..8]
    @people_clips = @clip.people.map{|person| person.clips}.flatten.uniq

    @topic_clips = @clip.related_topic_clips
    @meta_description = @clip.description
  end

  private

  def assign_webvtt
    Rails.logger.info "assign webvtt"
    @webvtt = @clip.webvtt
    Rails.logger.info "donw with assign webvtt"
  end



end