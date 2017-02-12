class AddAgecatpositionsAndAgegradePositionsToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :age_grade_position, :integer
    add_column :results, :age_cat_position, :integer
  end
end
