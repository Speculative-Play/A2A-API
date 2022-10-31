class ChangeParentProfileTable < ActiveRecord::Migration[7.0]
  def change
    add_column :parent_profiles, :password_digest, :string, null: false
    add_column :parent_profiles, :email, :string, null: false
  end
end
