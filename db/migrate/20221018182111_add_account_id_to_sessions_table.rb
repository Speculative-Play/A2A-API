class AddAccountIdToSessionsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :account_id, :integer
  end
end