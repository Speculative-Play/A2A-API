class Answer < ApplicationRecord
    belongs_to :user_answer, class_name: "user_answer", foreign_key: "user_answer_id"
    belongs_to :match_answer, class_name: "match_answer", foreign_key: "match_answer_id"
end
