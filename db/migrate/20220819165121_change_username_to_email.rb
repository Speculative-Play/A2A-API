class ChangeUsernameToEmail < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :username
    add_column :user_profiles, :email, :string
  end
end
