class RemoveTableMatchAnswers < ActiveRecord::Migration[7.0]
  def change
    drop_table :match_answers
  end
end
