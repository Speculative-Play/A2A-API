class Answer < ApplicationRecord
    # belongs_to :answerable, polymorphic: true
    belongs_to :question, class_name: "question", foreign_key: "question_id"
end
