require File.join(Kinney::Engine.config.root, 'app', 'models', 'kinney', 'image')

module Kinney
  class Image < ActiveRecord::Base
    
    def external_url
      File.join('http://example.com/', filename)
    end

  end
end