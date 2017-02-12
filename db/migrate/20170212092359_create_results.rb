class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
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

      t.timestamps
    end
  end
end
