class AddRememberDigestToParentProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :parent_profiles, :remember_digest, :string
  end
end
