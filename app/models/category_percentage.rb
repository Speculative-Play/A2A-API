class CategoryPercentage < ApplicationRecord
    belongs_to :matchmaking_category, class_name: "MatchmakingCategory", foreign_key: "matchmaking_category_id"
    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
end
