class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :nickname
      t.text :biography
      t.text :accomplishments
      t.text :activities
      t.text :currently
      t.text :citations
      t.integer :granduating_class
      t.text :term
      t.text :term_date_ranges

      t.timestamps
    end
  end
end
