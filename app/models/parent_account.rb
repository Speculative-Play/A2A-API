class ParentAccount < ApplicationRecord
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # could also use: 
    # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}


    belongs_to :user_profile, class_name: "UserProfile", foreign_key: "user_profile_id"
    has_many :starred_match_profiles, dependent: :destroy
    has_secure_password
end
