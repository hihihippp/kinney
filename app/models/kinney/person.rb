module Kinney
  class Person < ActiveRecord::Base
    include Kinney::Concerns::Models::Person
  end
end