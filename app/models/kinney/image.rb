module Kinney
  class Image < ActiveRecord::Base
    attr_accessible :filename, :top_pick, :person_ids
    
    has_many :person_images
    has_many :people, :through => :person_images
    
    validates_uniqueness_of :filename
    validates :filename, :presence => true

    def sal_path
      File.join('http://d.lib.ncsu.edu/collections/catalog/', filename)
    end

  end
end