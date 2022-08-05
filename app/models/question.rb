class Question < ApplicationRecord
    has_many :user_question_answers, class_name: "user_question_answer", foreign_key: "reference_id"
    has_many :match_question_answers, class_name: "match_question_answer", foreign_key: "reference_id"
end
