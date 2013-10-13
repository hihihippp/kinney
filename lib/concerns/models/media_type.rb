module Kinney::Concerns::Models::MediaType
  extend ActiveSupport::Concern

  included do
    has_many :clips

    validates_uniqueness_of :name
    validates :name, :presence => true
  end

  module ClassMethods

  end

end