class CreateStarredMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :starred_match_profiles do |t|
      t.references :parent_account, foreign_key: true, index: true 
      t.references :match_profile, foreign_key: true, index: true 
      t.timestamps
    end
  end
end
