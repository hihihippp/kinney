module Kinney
  module HomePageHelper
    def home_page_featured_clip_title
      title = @featured_clip.title
      title += content_tag :div,
      link_to(@person.full_name, @person),
      class: :person_title
      title.html_safe
    end
  end
end