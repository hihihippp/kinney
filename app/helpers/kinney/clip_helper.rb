module Kinney
  module ClipHelper
    include ::KinneyHelper
    
    def duration_pretty(clip)
      "(#{clip.duration_pretty})" if !clip.duration.blank?
    end

      
      def download_button(clip)
        link_to(clip.mp4, :class => 'btn', :id => 'download_mp4') do
          "<i class='icon-arrow-down'></i> #{t 'kinney.clips.show.download_mp4'}".html_safe
        end
      end
      
      # TODO: once we have VTT for everything change this and make VTT's manditory
      def vtt_button(clip)
        begin
          client = HTTPClient.new
          response = client.head(clip.vtt)
          link_to_options = {:class => 'btn', :id => 'download_vtt'}
          if response.status != 200
            link_to_options.merge!(:style => 'display:none')
          end
          link_to(clip.vtt, link_to_options) do
              "<i class='icon-arrow-down'></i> #{t :download_transcript}".html_safe
            end
        rescue
        end
      end

      def jump_time(timestamp)
        time_parts = timestamp.split(':')
        seconds = time_parts.pop
        minutes = time_parts.pop
        hours   = time_parts.first if !time_parts.blank?
        total_seconds = hours.to_i.hours.seconds
        total_seconds += minutes.to_i.minutes.seconds
        total_seconds += seconds.split('.').first.to_i
      end

      def scholarship_links
        [
          ['Guide to the Student Leaders Oral Histories', 'http://www.lib.ncsu.edu/findingaids/mc00401'],
          ["NCSU Libraries' Digital Collections", 'http://d.lib.ncsu.edu/collections/'],
          ['Historical State', 'http://historicalstate.lib.ncsu.edu/'],
          ["Oral history collections", 'http://www.lib.ncsu.edu/findingaids/search?keyword=oral+history'],
          ["Special Collections Research Center", 'http://www.lib.ncsu.edu/specialcollections/']
        ]
      end
      
      def topic_li_class(topic)
        current_page?(topic_path(topic)) ? 'active' : ''
      end

  end
end