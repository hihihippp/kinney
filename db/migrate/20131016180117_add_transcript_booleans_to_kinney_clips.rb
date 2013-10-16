class AddTranscriptBooleansToKinneyClips < ActiveRecord::Migration
  def change
    add_column :kinney_clips, :transcript_text, :boolean
    add_column :kinney_clips, :transcript_pdf, :boolean
  end
end
