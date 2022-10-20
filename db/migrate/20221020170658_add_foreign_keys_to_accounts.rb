class AddForeignKeysToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :user_profile, foreign_key: true
    add_reference :accounts, :parent_profile, foreign_key: true
  end
end
