class Question < ApplicationRecord
    has_many :user_question_answers
    has_many :match_question_answers
end
