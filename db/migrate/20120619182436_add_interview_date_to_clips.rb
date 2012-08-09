class AddInterviewDateToClips < ActiveRecord::Migration
  def change
    add_column :clips, :interview_date, :date
  end
end
