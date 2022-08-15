class Question < ApplicationRecord
    has_many :answers, class_name: "answer", foreign_key: "reference_id", :dependent => :destroy
    has_many :user_question_answers, :dependent => :destroy
    has_many :match_question_answers, :dependent => :destroy
    belongs_to :matchmaking_category, class_name: "matchmaking_category", foreign_key: "matchmaking_category_id"
end
