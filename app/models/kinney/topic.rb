module Kinney
  class Topic < ActiveRecord::Base
    attr_accessible :name, :description
    
    has_many :clip_topics
    has_many :clips, :through => :clip_topics
    
    extend FriendlyId
    friendly_id :name, :use => :history
    
    validates :name, :description, :presence => true
    validates_uniqueness_of :name
    
    default_scope order('name ASC')
    
    def self.with_clips
      joins(:clips).group("kinney_topics.id HAVING count(kinney_clips.id) > 0")
    end
    
  end
end
