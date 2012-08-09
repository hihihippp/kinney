class AddDescriptionToClips < ActiveRecord::Migration
  def change
    add_column :clips, :description, :text
  end
end
