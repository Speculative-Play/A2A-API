class RemoveRememberDigestFromUserProfilesAndParentProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :remember_digest
    remove_column :parent_profiles, :remember_digest
  end
end
