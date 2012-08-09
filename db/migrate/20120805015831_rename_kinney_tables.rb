class RenameKinneyTables < ActiveRecord::Migration
  def up
    rename_table :clip_people , :kinney_clip_people
    # rename_column :kinney_clip_people, :person_id, :kinney_person_id
    # rename_column :kinney_clip_people, :clip_id, :kinney_clip_id

    rename_table :clip_topics , :kinney_clip_topics
    # rename_column :kinney_clip_topics, :clip_id, :kinney_clip_id
    # rename_column :kinney_clip_topics, :topic_id, :kinney_topic_id

    rename_table :clips , :kinney_clips
    rename_table :images , :kinney_images
    rename_table :people , :kinney_people

    rename_table :person_images , :kinney_person_images
    # rename_column :kinney_person_images, :person_id, :kinney_person_id
    # rename_column :kinney_person_images, :image_id, :kinney_image_id

    rename_table :topics , :kinney_topics
    rename_table :trackers , :kinney_trackers
    rename_table :video_sessions , :kinney_video_sessions

    rename_table :admin_users, :kinney_admin_users
  end

  def down
  end
end
