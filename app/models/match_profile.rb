class MatchProfile < ApplicationRecord
    has_many :match_question_answers
    has_many :starred_match_profiles
end
