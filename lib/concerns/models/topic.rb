module Kinney::Concerns::Models::Topic
  extend ActiveSupport::Concern

  included do
    has_many :clip_topics
    has_many :clips, :through => :clip_topics

    extend FriendlyId
    # FIXME: add back in use :history
    friendly_id :name, :use => [:slugged, :history]

    validates :name, :description, :presence => true
    validates_uniqueness_of :name

    default_scope {order('name ASC')}
  end

  module ClassMethods
    def with_clips
      joins(:clips).group("kinney_topics.id HAVING count(kinney_clips.id) > 0")
    end
  end
end