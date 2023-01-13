class AddBiodataToMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :match_profiles, :education, :string
    add_column :match_profiles, :occupation, :string
    add_column :match_profiles, :religion, :string
    add_column :match_profiles, :father, :string
    add_column :match_profiles, :mother, :string
    add_column :match_profiles, :sisters, :text, default: ""
    add_column :match_profiles, :brothers, :text, default: ""
    add_column :match_profiles, :about_me, :text, default: ""
  end
end
