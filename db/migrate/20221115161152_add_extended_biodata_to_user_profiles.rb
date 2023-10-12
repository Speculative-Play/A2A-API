class AddExtendedBiodataToUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :user_profiles, :education, :string
    add_column :user_profiles, :occupation, :string
    add_column :user_profiles, :religion, :string
    add_column :user_profiles, :father, :string
    add_column :user_profiles, :mother, :string
    add_column :user_profiles, :sisters, :text, default: ""
    add_column :user_profiles, :brothers, :text, default: ""
    add_column :user_profiles, :about_me, :text, default: ""
  end
end
