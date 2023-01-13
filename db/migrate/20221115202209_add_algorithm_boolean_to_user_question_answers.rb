class AddAlgorithmBooleanToUserQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :user_question_answers, :matching_algo, :boolean, default: true
  end
end
