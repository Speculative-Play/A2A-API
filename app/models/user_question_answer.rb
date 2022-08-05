class UserQuestionAnswer < ApplicationRecord
    belongs_to :question, class_name: "question", foreign_key: "question_id"
    belongs_to :answer, class_name: "answer", foreign_key: "answer_id"
    belongs_to :user_profile, class_name: "user_profile", foreign_key: "user_profile_id"
end
