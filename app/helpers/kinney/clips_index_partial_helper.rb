module Kinney
  module ClipsIndexPartialHelper
    # Override this helper and this message in your own app to choose a different partial.
    # Besides the option below you can also create your own partial in your main application under
    # /views/kinney/clips/. Or you can select to list all the videos with 'all_clips'
    def clips_index_partial
      'clips_grouped_by_person'
      # 'all_clips'
    end
  end
end