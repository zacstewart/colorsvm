class AddUniqueIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :unique_id, :string
  end
end
