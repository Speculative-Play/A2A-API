class MatchProfile < ApplicationRecord
    has_many :match_question_answers, class_name: "match_question_answer", foreign_key: "reference_id", dependent: :destroy
    has_many :starred_match_profiles, class_name: "starred_match_profile", foreign_key: "reference_id", dependent: :destroy
    has_one_attached :image, :dependent => :destroy
end
