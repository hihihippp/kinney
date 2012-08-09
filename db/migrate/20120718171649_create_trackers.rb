class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.string :uuid
      t.text :seconds
      t.string :video
      t.string :site
      t.date :time
      t.string :session
      t.boolean :sessioned

      t.timestamps
    end
  end
end
