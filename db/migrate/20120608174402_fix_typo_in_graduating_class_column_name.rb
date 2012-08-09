class FixTypoInGraduatingClassColumnName < ActiveRecord::Migration
  def change
    rename_column :people, :granduating_class, :graduating_class
  end

end
