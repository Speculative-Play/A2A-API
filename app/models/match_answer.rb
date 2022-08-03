class MatchAnswer < ApplicationRecord
    belongs_to :match_profile, class_name: "match_profile", foreign_key: "match_profile_id"
    has_many :answers, as: :answerable
end
