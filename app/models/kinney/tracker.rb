module Kinney
  class Tracker < ActiveRecord::Base
    serialize :seconds, Array
  end
end

# == Schema Information
#
# Table name: kinney_trackers
#
#  id         :integer          not null, primary key
#  uuid       :string(255)
#  seconds    :text
#  video      :string(255)
#  site       :string(255)
#  time       :date
#  session    :string(255)
#  sessioned  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

