class RenameParentAccountIdColumnInStarredMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_column :starred_match_profiles, :parent_account_id, :parent_profile_id
  end
end
