class RenameAccountsTableToAccounts < ActiveRecord::Migration[7.0]
  def change
    rename_table :accounts_tables, :accounts
  end
end
