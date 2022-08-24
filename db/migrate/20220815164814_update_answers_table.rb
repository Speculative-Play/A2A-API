class UpdateAnswersTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :question_id
    remove_column :answers, :answerable_id
    remove_column :answers, :answerable_type
    add_reference :answers, :question, foreign_key: true
  end
end
