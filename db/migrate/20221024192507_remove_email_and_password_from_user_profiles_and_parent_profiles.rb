class RemoveEmailAndPasswordFromUserProfilesAndParentProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :email
    remove_column :user_profiles, :password_digest
    remove_column :parent_profiles, :email
    remove_column :parent_profiles, :password_digest
  end
end
