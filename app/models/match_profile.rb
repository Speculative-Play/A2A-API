class MatchProfile < ApplicationRecord
    has_many :match_answers, class_name: "match_answer", foreign_key: "match_answer_id"
end
