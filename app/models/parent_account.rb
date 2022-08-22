class ParentAccount < ApplicationRecord
    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
    has_many :starred_match_profiles, class_name: "StarredMatchProfile", dependent: :destroy
    has_secure_password
end
