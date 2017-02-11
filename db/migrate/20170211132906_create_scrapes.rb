class CreateScrapes < ActiveRecord::Migration[5.0]
  def change
    create_table :scrapes do |t|
      t.string :nullfield

      t.timestamps
    end
  end
end
