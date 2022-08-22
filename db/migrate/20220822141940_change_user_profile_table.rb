class ChangeUserProfileTable < ActiveRecord::Migration[7.0]
  def change
    add_column :user_profiles, :first_name, :string, null: false
    add_column :user_profiles, :last_name, :string, null: false
  end
end
