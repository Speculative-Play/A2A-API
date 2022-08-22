class ChangeParentAccountTable < ActiveRecord::Migration[7.0]
  def change
    add_column :parent_accounts, :password_digest, :string, null: false
    add_column :parent_accounts, :email, :string, null: false
  end
end
