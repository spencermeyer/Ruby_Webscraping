class AddAthleteNumberToStalkee < ActiveRecord::Migration[5.1]
  def up
    add_column :stalkees, :athlete_number, :integer
  end

  def down
    remove_column :stalkees, :athlete_number
  end
end
