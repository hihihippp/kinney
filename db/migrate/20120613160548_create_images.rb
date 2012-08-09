class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.boolean :top_pick

      t.timestamps
    end
    
    create_table :person_images do |t|
      t.references :person
      t.references :image
      
      t.timestamps
    end
  end
end
