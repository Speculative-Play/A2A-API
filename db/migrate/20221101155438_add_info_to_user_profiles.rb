class AddInfoToUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :user_profiles, :gender, :string
    add_column :user_profiles, :city, :string
    add_column :user_profiles, :country, :string
    add_column :user_profiles, :birth_country, :string
    add_column :user_profiles, :date_of_birth, :date
    add_column :user_profiles, :languages, :text, default: ""
    add_column :user_profiles, :marital_status, :string
  end
end
