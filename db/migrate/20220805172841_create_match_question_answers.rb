class CreateMatchQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :match_question_answers do |t|
      t.references :question, foreign_key: true, index: true 
      t.references :answer, foreign_key: true, index: true 
      t.references :match_profile, foreign_key: true, index: true 
      t.timestamps
    end
  end
end
