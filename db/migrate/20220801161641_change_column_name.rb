class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :name, :first_name
  end
end
