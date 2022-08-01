class RemoveColumnsFromTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :first_name
    remove_column :profiles, :age 
    remove_column :profiles, :location
  end
end
