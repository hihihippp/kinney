class CreateVideoSessions < ActiveRecord::Migration
  def change
    create_table :video_sessions do |t|
      t.string :uuid
      t.text :seconds
      t.string :video
      t.string :site
      t.date :time
      t.string :session

      t.timestamps
    end
  end
end
