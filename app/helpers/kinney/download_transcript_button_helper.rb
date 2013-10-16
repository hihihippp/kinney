module Kinney
  module DownloadTranscriptButtonHelper
    def download_transcript_button(clip)
      render partial: '/kinney/clips/download_transcript_button', locals: {clip: clip}
    end
  end
end