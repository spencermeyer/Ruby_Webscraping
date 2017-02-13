class AddAthleteNumberToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :athlete_number, :integer
  end
end
