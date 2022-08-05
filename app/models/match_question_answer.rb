class MatchQuestionAnswer < ApplicationRecord
    belongs_to :question, class_name: "question", foreign_key: "question_id"
    belongs_to :answer, class_name: "answer", foreign_key: "answer_id"
    belongs_to :match_profile, class_name: "match_profile", foreign_key: "match_profile_id"
end
