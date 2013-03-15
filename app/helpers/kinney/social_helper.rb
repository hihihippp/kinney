module Kinney
  module SocialHelper

    def email_to_resource
      body = url_encode "#{@clip.people_with_title} #{current_url}"
      subject = 'Check out this video from NCSU Libraries'
      "mailto:?subject=#{subject}&body=#{body}" 
    end

    def googleplus_url_for_resource
      url_params = {url: current_url}
      "https://plus.google.com/share?#{url_params.to_query}"
    end

    def facebook_url_for_resource
      url_params = {u:current_url, title: @clip.people_with_title}
      "http://www.facebook.com/share.php?#{url_params.to_query}"
    end

    def twitter_url_for_resource
      url_params = {text: @clip.people_with_title , url: current_url, via: 'ncsulibraries'}
      "http://twitter.com/share?#{url_params.to_query}"
    end

  end
end