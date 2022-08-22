class MatchProfile < ApplicationRecord
    has_many :match_question_answers, dependent: :destroy
    has_many :starred_match_profiles, dependent: :destroy
    has_one_attached :image, :dependent => :destroy
end
