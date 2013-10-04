module Kinney
  class Person < ActiveRecord::Base

    validates :last_name, :presence => true
    validates_uniqueness_of :last_name, :scope => :first_name

    has_many :clip_people
    has_many :clips, :through => :clip_people
    has_many :person_images
    has_many :images, :through => :person_images

    extend FriendlyId
    # FIXME: add back in use :history
    friendly_id :full_name, :use => [:slugged]

    default_scope {order('last_name asc')}

    # tire for elasticsearch
    include Tire::Model::Search
    include Tire::Model::Callbacks

    index_name "kinney_#{Rails.application.class.parent_name.parameterize}_#{Rails.env}"

    mapping do
      indexes :id,           :index    => :not_analyzed
      indexes :filename,     :index => :not_analyzed
      indexes :accomplishments,       :analyzer => 'snowball'
      indexes :activities,       :analyzer => 'snowball'
      indexes :biography,       :analyzer => 'snowball'
      indexes :citations,       :analyzer => 'snowball'
      indexes :graduating_class,      :analyzer => 'date'
      indexes :last_name, :analyzer => 'snowball', :boost => 100
      indexes :first_name, :analyzer => 'snowball'
      indexes :middle_name, :analyzer => 'snowball'
    end
    settings :index => {
          :analysis => {
            :analyzer => {
              :default => {
                :type => 'snowball'
              }
            }
          }
        }

    def self.with_clips
      joins(:clips).group("kinney_people.id HAVING count(kinney_clips.id) > 0")
    end

    def self.with_top_pick_clip
      joins(:clips).where('kinney_clips.top_pick' => true)
    end

    def top_pick_clip
      clips.where(:top_pick => true).limit(1).first
    end

    def self.with_images
      joins(:images).group("kinney_people.id HAVING count(kinney_images.id) > 0")
    end
    def self.without_images
      includes(:person_images).where(:kinney_person_images => {:person_id => nil})
    end


    def to_label
      "#{last_name}, #{first_name}"
    end

    def full_name
      fn = ''
      fn << first_name if !first_name.blank?
      fn << ' ' + middle_name if !middle_name.blank?
      fn << ' ' + last_name if !last_name.blank?
      fn << ', ' + name_suffix if !name_suffix.blank?
      fn
    end

    def short_bio
      HTML_Truncator.truncate(biography, 20).html_safe
    end

    def short_bio_text
      Nokogiri::HTML(short_bio).text
    end

    def image
      image = images.where(:top_pick => true).limit(1).first
      if image.blank?
        image = images.first
      end
      image
    end

    def read_more_link_params
      read_more_link_params_hash = {:class => [:thumbnail, :person_read_more, :clearfix]}
      if !biography.blank?
        read_more_link_params_hash.merge!({:rel=> :popover, :'data-content' => short_bio_text, :'data-original-title' => full_name})
      end
      read_more_link_params_hash

    end

  end
end