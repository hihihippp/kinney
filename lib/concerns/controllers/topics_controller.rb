module Kinney::Concerns::Controllers::ClipTopicsController
  extend ActiveSupport::Concern

  def index
    @topics = Kinney::Topic.with_clips
  end

  def show
    @topic = Kinney::Topic.friendly.find(params[:id])
    @title = @topic.name
    @meta_description = @topic.description
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the topic_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if !@topic.slug.blank? and params[:id] != @topic.slug
      return redirect_to @topic, :status => :moved_permanently
    end
  end

end