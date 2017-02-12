class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.string :run_identifier

      t.timestamps
    end
  end
end
