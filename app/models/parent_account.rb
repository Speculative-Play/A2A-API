class ParentAccount < ApplicationRecord
    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
    has_many :starred_match_profiles
    # TODO test validation functionality below
    # validates_presence_of :username, comparison {equal_to: :child_username}
    # validate :username_matches
    has_secure_password

    # protected

    # def username_matches
    #     errors.add(:username, "doesn't match") unless UserProfile.username == child_username
    # end
end
