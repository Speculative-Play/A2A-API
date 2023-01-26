class GlobalUserMatchScore < ApplicationRecord
    belongs_to :user_profile,   optional: true
    belongs_to :match_profile,  optional: true