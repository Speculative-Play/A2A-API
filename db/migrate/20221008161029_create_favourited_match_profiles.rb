class CreateFavouritedMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :favourited_match_profiles do |t|
      t.references :user_profile, foreign_key: true, index: true 
      t.references :match_profile, foreign_key: true, index: true 
      t.timestamps
    end
  end
end
