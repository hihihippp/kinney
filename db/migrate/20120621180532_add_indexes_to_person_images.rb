class AddIndexesToPersonImages < ActiveRecord::Migration
  def change
    add_index :person_images, :person_id
    add_index :person_images, :image_id
    add_index :images,        :id
  end
end
