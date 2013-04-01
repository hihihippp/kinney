module Kinney
  class Clip < ActiveRecord::Base

    strip_attributes

    attr_accessible :filename, :quotes, :title, :top_pick, :topic_ids, :person_ids,
      :duration, :interview_date, :description, :featured
    
    has_many :clip_people
    has_many :people, :through => :clip_people
    
    has_many :clip_topics
    has_many :topics, :through => :clip_topics
    
    validates :filename, :duration, :title, :description, :interview_date, :presence => true
    validates_uniqueness_of :filename

    validate :valid_number_of_people
    validate :valid_number_of_topics
    
    extend FriendlyId
    friendly_id :title_and_last_names, :use => [:slugged, :history]

    default_scope order('top_pick desc, title asc')

    # tire for elasticsearh
    include Tire::Model::Search
    include Tire::Model::Callbacks
    index_name "kinney_#{Rails.env}"
    mapping do
      indexes :id,           :index    => :not_analyzed    
      indexes :filename,     :index => :not_analyzed
      indexes :quotes,       :analyzer => 'snowball'
      indexes :title,        :analyzer => 'snowball', :boost => 100
      indexes :description,  :analyzer => 'snowball'
      indexes :people,       :analyzer => 'keyword', :as => Proc.new{|clip| clip.people.map{|person| person.full_name}}
      indexes :topics,       :analyzer => 'snowball', :as => Proc.new{|clip| clip.topics.map{|topic| topic.name}}
      indexes :webvtt,       :analyzer => 'snowball', :as => Proc.new{|clip| clip.webvtt.cues.map{|cue| cue.text} if clip.webvtt}
      indexes :top_pick,     :type => 'boolean'
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
    # for elasticsearch/tire
    def to_indexed_json
      hash = attributes
      hash[:people] = people.map{|person| person.full_name}
      hash[:topics] = topics.map{|topic| topic.name}

      web_vtt = webvtt
      hash[:webvtt] = web_vtt.cues.map{|cue| cue.text} if web_vtt

      hash.to_json
    end
    # end elasticsearch end
     
    
    def self.top_picks
      where(:top_pick => true)
    end

    def title_and_filename
      "#{title} #{filename}"
    end

    def title_and_last_names
      "#{title} #{people_names}"
    end

    def title_with_full_people_names
      "#{title} with #{full_people_names}"
    end
    
    def topic_names
      topics.map{|topic| topic.name}
    end
    
    def people_with_title
      "#{people_names}: #{title}"
    end
    
    def people_names
      names = people.map{|person| person.last_name}
      if names.length > 2
        name_last = names.pop
        final_names = names.join(', ')
        final_names << ', and ' << name_last
      elsif names.length == 2
        names.join(' and ')
      else
        names.first
      end
    end

    def full_people_names
      names = people.map{|person| person.full_name}
      if names.length > 2
        name_last = names.pop
        final_names = names.join(', ')
        final_names << ', and ' << name_last
      elsif names.length == 2
        names.join(' and ')
      else
        names.first
      end
    end
      
    # def siskel_path(opts={})
    #   "http://example.com"
    # end
    
    def png
      siskel_path({:extension => 'png'})
    end
    
    def mp4
      siskel_path({:extension => 'mp4'})
    end
    
    def webm
      siskel_path({:extension => 'webm'})
    end
    
    # URL to webvtt file
    def vtt #closed_captioning vtt file
      siskel_path({:extension => 'vtt'})
    end

    include ::KinneyClipHelper

    # parsed WEBVTT file
    def webvtt
      begin
        client = HTTPClient.new
        response = client.get(vtt)
        if response.status == 200
          Webvtt::File.new(response.body)
        else
          false        
        end
      rescue
      end 
    end

    def chapters #vtt file
    end
    
    def video_switcher_params
      video_switcher_params_hash = {:class => :clearfix}
      if !description.blank?
        video_switcher_params_hash.merge!({:rel=> :popover, :'data-content' => description, :'data-original-title' => title})
      end
      video_switcher_params_hash
    end
    
    def duration_iso8601
      hours  =  duration / 1.hour
      minutes = (duration - hours.hours) / 1.minute
      seconds = duration - hours.hours - minutes.minutes
      output = 'T'
      output << "#{hours}H" if hours > 0
      output << "#{minutes}M" if minutes > 0
      output << "#{seconds}S" if seconds > 0
      output
    end

    def duration_pretty
      if !duration.blank?
        total_minutes = duration / 1.minutes
        seconds_in_last_minute = duration - total_minutes.minutes.seconds
        %Q|#{total_minutes}:#{"%02d" % seconds_in_last_minute}|
      end
    end

    def related_topic_clips
      # FIXME: this could probably done in one nice query
      topics.map{|topic| topic.clips}.flatten.uniq - [self]
    end

  private

    def valid_number_of(association)
      errors.add(association, "Must select at least one person.") if send(association).size == 0
    end
    def valid_number_of_people
      valid_number_of(:people)
    end
    def valid_number_of_topics
      valid_number_of(:topics)
    end
  end
end