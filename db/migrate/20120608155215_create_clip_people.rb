class CreateClipPeople < ActiveRecord::Migration
  def change
    create_table :clip_people do |t|
      t.references :person
      t.references :clip

      t.timestamps
    end
    add_index :clip_people, :person_id
    add_index :clip_people, :clip_id
  end
end
