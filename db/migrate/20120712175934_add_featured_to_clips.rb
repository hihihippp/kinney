class AddFeaturedToClips < ActiveRecord::Migration
  def change
    add_column :clips, :featured, :boolean
  end
end
