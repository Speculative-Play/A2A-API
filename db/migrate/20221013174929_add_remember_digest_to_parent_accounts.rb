class AddRememberDigestToParentAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :parent_accounts, :remember_digest, :string
  end
end
