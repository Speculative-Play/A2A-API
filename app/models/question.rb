class Question < ApplicationRecord
    has_many :user_question_answers, class_name: "user_question_answer", foreign_key: "reference_id"
end
