class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.text :ip_address
      t.text :browser

      t.timestamps
    end
  end
end
