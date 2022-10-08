class FavouritedMatchProfile < ApplicationRecord
    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
    belongs_to :match_profile, class_name: "MatchProfile", foreign_key: "match_profile_id"
end
