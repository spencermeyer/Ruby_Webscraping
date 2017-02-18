class CreateMilestones < ActiveRecord::Migration[5.0]
  def change
    create_table :milestones do |t|
      t.integer :pos
      t.string :parkrunner
      t.string :time
      t.string :age_cat
      t.string :age_grade
      t.string :gender
      t.string :gender_pos
      t.string :club
      t.string :note
      t.integer :total
      t.integer :run_id
      t.integer :age_grade_position
      t.integer :age_cat_position
      t.string :athlete_number
      t.string :integer

      t.timestamps
    end
  end
end
