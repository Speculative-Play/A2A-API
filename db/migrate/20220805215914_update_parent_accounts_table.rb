class UpdateParentProfilesTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :parent_profiles, :child_username
    remove_column :parent_profiles, :user_id
    add_reference :parent_profiles, :user_profile, foreign_key: true
  end
end
