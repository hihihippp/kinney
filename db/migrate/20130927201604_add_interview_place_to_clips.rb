class AddInterviewPlaceToClips < ActiveRecord::Migration
  def change
    add_column :kinney_clips, :interview_place, :string
  end
end
