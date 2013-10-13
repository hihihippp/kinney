module Kinney
  class Clip < ActiveRecord::Base
    include Kinney::Concerns::Models::Clip
  end
end

# == Schema Information
#
# Table name: kinney_clips
#
#  id              :integer          not null, primary key
#  filename        :string(255)
#  title           :string(255)
#  quotes          :text
#  top_pick        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slug            :string(255)
#  duration        :integer
#  interview_date  :date
#  description     :text
#  featured        :boolean
#  interview_place :string(255)
#

