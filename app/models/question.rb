class Question < ApplicationRecord
    has_many :answers, dependent: :destroy
    has_many :user_question_answers, dependent: :destroy
    has_many :match_question_answers, dependent: :destroy
    belongs_to :matchmaking_category, class_name: "MatchmakingCategory", foreign_key: "matchmaking_category_id"
end
