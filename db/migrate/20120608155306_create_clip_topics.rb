class CreateClipTopics < ActiveRecord::Migration
  def change
    create_table :clip_topics do |t|
      t.references :clip
      t.references :topic

      t.timestamps
    end
    add_index :clip_topics, :clip_id
    add_index :clip_topics, :topic_id
  end
end
