class UserQuestionAnswer < ApplicationRecord
    belongs_to :question, class_name: "Question", foreign_key: "question_id"
    belongs_to :answer, class_name: "Answer", foreign_key: "answer_id"
    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
end
