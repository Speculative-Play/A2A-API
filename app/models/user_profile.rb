class UserProfile < ApplicationRecord
    before_save { self.username = username.downcase }
    has_one :parent_account, dependent: :destroy
    has_many :starred_match_profiles, through: :parent_account
    has_many :user_question_answers
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 15 }
    has_secure_password
end
