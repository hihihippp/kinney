require File.join(Kinney::Engine.config.root, 'app', 'models', 'kinney', 'image')

module Kinney
  class Image < ActiveRecord::Base
    
    def external_url
      File.join('http://d.lib.ncsu.edu/collections/catalog/', filename)
    end

  end
end