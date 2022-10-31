class AddRememberDigestToUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :user_profiles, :remember_digest, :string
  end
end
