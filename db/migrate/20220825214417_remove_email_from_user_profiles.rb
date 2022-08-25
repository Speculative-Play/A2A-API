class RemoveEmailFromUserProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :email
  end
end
