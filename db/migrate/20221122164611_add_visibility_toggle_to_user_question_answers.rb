class AddVisibilityToggleToUserQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :user_question_answers, :visible, :boolean, default: true
  end
end
