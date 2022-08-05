class UpdateParentAccountsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :parent_accounts, :child_username
    remove_column :parent_accounts, :user_id
    add_reference :parent_accounts, :user_profile, foreign_key: true
  end
end
