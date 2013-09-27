class AddHonoraryToPerson < ActiveRecord::Migration
  def change
    add_column :kinney_people, :honorary, :string
  end
end
