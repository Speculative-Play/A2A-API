class CreateMatchAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :match_answers do |t|
      t.integer "match_profile_id"
      t.integer "answer_id"
      t.timestamps
    end
  end
end
