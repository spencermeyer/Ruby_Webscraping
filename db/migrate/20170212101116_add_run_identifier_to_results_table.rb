class AddRunIdentifierToResultsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :run_id, :integer
  end
end
