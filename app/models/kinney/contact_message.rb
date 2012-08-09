module Kinney
  class ContactMessage

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :name, :graduating_class, :email, :comment

    validates :name, :email, :comment, :presence => true
    validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end

  end
end