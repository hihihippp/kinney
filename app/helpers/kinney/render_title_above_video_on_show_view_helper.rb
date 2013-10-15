module Kinney
  module RenderTitleAboveVideoOnShowViewHelper
    def render_title_above_video_on_show_view(clip)
      render partial: 'title_and_linked_name_heading', locals: {clip: clip}
    end
  end
end