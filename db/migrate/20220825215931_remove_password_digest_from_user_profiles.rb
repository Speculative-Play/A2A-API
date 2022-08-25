class RemovePasswordDigestFromUserProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :password_digest
  end
end
