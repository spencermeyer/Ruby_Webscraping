class AddMetadataToRun < ActiveRecord::Migration[5.0]
  def up
    add_column :runs, :metadata, :text
  end

  def down
    remove_column :runs, :metadata
    end
end