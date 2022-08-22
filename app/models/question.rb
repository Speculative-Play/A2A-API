class Question < ApplicationRecord
    has_many :answers, class_name: "Answer", foreign_key: "reference_id", dependent: :destroy
    has_many :user_question_answers, class_name: "UserQuestionAnswer", dependent: :destroy
    has_many :match_question_answers, class_name: "MatchQuestionAnswer", dependent: :destroy
    belongs_to :matchmaking_category, class_name: "MatchmakingCategory", foreign_key: "matchmaking_category_id"
end
