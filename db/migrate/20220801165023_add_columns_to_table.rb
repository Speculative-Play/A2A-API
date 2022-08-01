class AddColumnsToTable < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :first_name, :string 
    add_column :profiles, :last_name, :string 
    add_column :profiles, :age, :integer 
    add_column :profiles, :location, :string
  end
end
