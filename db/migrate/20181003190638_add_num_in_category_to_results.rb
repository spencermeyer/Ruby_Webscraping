class AddNumInCategoryToResults < ActiveRecord::Migration[5.1]
  def up
    add_column :results, :number_in_age_category, :integer
  end

  def down
    remove_column :results, :number_in_age_category
  end
end
