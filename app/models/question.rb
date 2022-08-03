class Question < ApplicationRecord
    belongs_to :answer, class_name: "answer", foreign_key: "answer_id"
end
