module Kinney
  class Person < ActiveRecord::Base
    attr_accessible :accomplishments, :activities, :biography, :citations,
      :currently, :first_name, :graduating_class, :last_name, :middle_name,
      :nickname, :term, :term_date_ranges, :name_suffix, :location
    
    validates :last_name, :presence => true
    validates_uniqueness_of :last_name, :scope => :first_name
    
    has_many :clip_people
    has_many :clips, :through => :clip_people
    has_many :person_images
    has_many :images, :through => :person_images
    
    extend FriendlyId
    friendly_id :full_name, :use => [:slugged, :history]
    
    default_scope order('last_name asc')

    # tire for elasticsearch
    include Tire::Model::Search
    include Tire::Model::Callbacks
    index_name "kinney_#{Rails.env}"
    mapping do
      indexes :id,           :index    => :not_analyzed    
      indexes :filename,     :index => :not_analyzed
      indexes :accomplishments,       :analyzer => 'snowball'
      indexes :activities,       :analyzer => 'snowbalwilliaml'
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
      images.where(:top_pick => true).limit(1).first
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