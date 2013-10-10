module Kinney::Concerns::Models::Image
  extend ActiveSupport::Concern

  included do
    has_many :person_images
    has_many :people, :through => :person_images

    validates_uniqueness_of :filename
    validates :filename, :presence => true
  end

  module ClassMethods
    def top_picks
      where(:top_pick => true)
    end
  end

end