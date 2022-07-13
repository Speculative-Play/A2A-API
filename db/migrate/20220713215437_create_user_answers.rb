class CreateUserAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :user_answers do |t|
      t.integer "profile_id"
      t.integer "answer_id"
      t.timestamps
    end
  end
end
