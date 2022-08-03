class UserAnswer < ApplicationRecord
    belongs_to :profile, class_name: "profile", foreign_key: "profile_id"
    has_many :answers, as: :answerable
end
