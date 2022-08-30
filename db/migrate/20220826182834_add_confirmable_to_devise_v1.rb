class AddConfirmableToDeviseV1 < ActiveRecord::Migration[7.0]
  def change
    change_table(:user_profiles) do |t| 
      t.confirmable 
    end
    add_index  :user_profiles, :confirmation_token, :unique => true 
  end
end
