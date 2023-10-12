class AddAcountTypeToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :account_type, :integer
  end
end
