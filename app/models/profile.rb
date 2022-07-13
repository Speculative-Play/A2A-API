class Profile < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_many :answers, class_name: "Answer", foreign_key: "answer_id"
end
