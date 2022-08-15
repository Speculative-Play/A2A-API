class ChangeColumnInQuestionsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :question_category
    add_reference :questions, :matchmaking_category, foreign_key: true
  end
end
