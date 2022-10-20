class ChangeParentProfileToParentProfile < ActiveRecord::Migration[7.0]
  def change
    rename_table :parent_profiles, :parent_profiles
  end
end
