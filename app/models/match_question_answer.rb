class MatchQuestionAnswer < ApplicationRecord
    belongs_to :question, class_name: "Question", foreign_key: "question_id"
    belongs_to :answer, class_name: "Answer", foreign_key: "answer_id"
    belongs_to :match_profile, class_name: "MatchProfile", foreign_key: "match_profile_id"
end
