class AddSlugsToClipsPeopleAndTopics < ActiveRecord::Migration
  def change
    add_column :clips, :slug, :string
    add_index  :clips, :slug, :unique => true
    
    add_column :people, :slug, :string
    add_index  :people, :slug, :unique => true
    
    add_column :topics, :slug, :string
    add_index  :topics, :slug, :unique => true
  end
end
