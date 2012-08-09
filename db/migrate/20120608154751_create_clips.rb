class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.string :filename
      t.string :title
      t.text :quotes
      t.boolean :top_pick

      t.timestamps
    end
  end
end
