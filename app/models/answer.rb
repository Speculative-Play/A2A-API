class Answer < ApplicationRecord
    has_many :user_question_answers,    dependent: :destroy
    has_many :match_question_answers,   dependent: :destroy
    belongs_to :question,   class_name: "Question",     foreign_key: "question_id"
end
