class AddInfoToMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :match_profiles, :gender, :string
    add_column :match_profiles, :city, :string
    add_column :match_profiles, :country, :string
    add_column :match_profiles, :birth_country, :string
    add_column :match_profiles, :date_of_birth, :date
    add_column :match_profiles, :languages, :text, default: ""
    add_column :match_profiles, :marital_status, :string
  end
end