class CreateParentAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :parent_accounts do |t|
      t.integer :user_id
      t.string :child_username
      t.timestamps
    end
  end
end
