module Kinney
  class Image < ActiveRecord::Base
    include Kinney::Concerns::Models::Image

    def external_url
      File.join('http://d.lib.ncsu.edu/collections/catalog/', filename)
    end

  end
end