module Kinney
  class Person < ActiveRecord::Base
    include Kinney::Concerns::Models::Person
  end
end

# == Schema Information
#
# Table name: kinney_people
#
#  id               :integer          not null, primary key
#  first_name       :string(255)
#  middle_name      :string(255)
#  last_name        :string(255)
#  nickname         :string(255)
#  biography        :text
#  accomplishments  :text
#  activities       :text
#  currently        :text
#  citations        :text
#  graduating_class :integer
#  term             :text
#  term_date_ranges :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string(255)
#  name_suffix      :string(255)
#  location         :string(255)
#  honorary         :string(255)
#

