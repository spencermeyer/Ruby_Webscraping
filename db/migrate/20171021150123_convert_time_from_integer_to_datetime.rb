class ConvertTimeFromIntegerToDatetime < ActiveRecord::Migration[5.0]
  def change
    change_column :results, :time, 'integer USING CAST(time AS integer)'
  end
end
