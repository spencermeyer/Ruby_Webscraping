class CreateStalkees < ActiveRecord::Migration[5.0]
  def change
    create_table :stalkees do |t|
      t.string :parkrunner

      t.timestamps
    end
  end
end
