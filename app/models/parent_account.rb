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

    class << self
        # Return the hash value of the given string
        def digest(string)
            puts "inside parent_account model digest(string)"
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        # Return a random token
        def generate_token
            puts "inside parent_account model generate_token"

            SecureRandom.urlsafe_base64
        end
    end

    #Create a new token -> encrypt it -> stores the hash value in remember_digest in DB
    def remember
        puts "inside parent_account model remember"

        self.remember_token = ParentAccount.generate_token
        update_attribute(:remember_digest, ParentAccount.digest(remember_token))
    end

    # Check if the given token value matches the one stored in DB
    def authenticated?(remember_token)
        puts "inside parent_account model authenticated?(remember_token)"

        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        puts "inside parent_account model forget"

        update_attribute(:remember_digest, nil)
    end
end
