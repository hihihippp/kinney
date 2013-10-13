class CreateKinneyMediaTypes < ActiveRecord::Migration
  def change
    create_table :kinney_media_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :kinney_media_types, :name, unique: true
  end
end
