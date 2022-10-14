class AddSessionTypeToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :session_type, :integer
  end
end
