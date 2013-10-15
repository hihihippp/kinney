class CreateKinneyInterviewerPeople < ActiveRecord::Migration
  def change
    create_table :kinney_interviewer_people do |t|
      t.references :clip, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end
