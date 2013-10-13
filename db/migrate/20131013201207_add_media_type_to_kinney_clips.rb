class AddMediaTypeToKinneyClips < ActiveRecord::Migration
  def change
    add_column :kinney_clips, :media_type_id, :integer
  end
end
