module Kinney
  class Image < ActiveRecord::Base
    attr_accessible :filename, :top_pick, :person_ids
    
    has_many :person_images
    has_many :people, :through => :person_images
    
    validates_uniqueness_of :filename
    validates :filename, :presence => true

    # This method should now be defined in the image override which is installed as part of the kinney:install generator
    # def external_url
    #   false
    # end

    def self.top_picks
      where(:top_pick => true)
    end

  end
end