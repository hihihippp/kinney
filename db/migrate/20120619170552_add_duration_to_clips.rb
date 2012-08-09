class AddDurationToClips < ActiveRecord::Migration
  def change
    add_column :clips, :duration, :integer
  end
end
