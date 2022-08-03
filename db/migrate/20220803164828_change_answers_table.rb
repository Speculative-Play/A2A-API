class ChangeAnswersTable < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :answerable_id, :integer
    add_column :answers, :answerable_type, :string, null: false
  end
end
