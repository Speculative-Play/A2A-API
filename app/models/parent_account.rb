class ParentAccount < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    # TODO test validation functionality below
    validates_presence_of :username comparison {equal_to: :child_username}
    validate :username_matches
    has_secure_password

    protected

    def username_matches
        errors.add(:username, "doesn't match") unless User.username == child_username
    end
end
