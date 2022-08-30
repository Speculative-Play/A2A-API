class RemoveEmailPasswordFromUserProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :email
    remove_column :user_profiles, :password
  end
end
