class Account < ApplicationRecord
    # attr_accessor :remember_token, :remember_digest

    belongs_to :user_profile,   optional: true
    belongs_to :parent_profile, optional: true

    before_validation { self.email = email.downcase }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}

    validates :password_digest, presence: true
    has_secure_password

    # # class << self
    #     # Return the hash value of the given string
    #     def Account.digest(string)
    #         cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    #         BCrypt::Password.create(string, cost: cost)
    #     end

    #     # Return a random token
    #     def Account.generate_token
    #         SecureRandom.urlsafe_base64
    #     end

    #     # Create a new token -> encrypt it -> stores the hash value in remember_digest in DB.
    #     def remember
    #         self.remember_token = Account.generate_token
    #         update_attribute(:remember_digest, Account.digest(remember_token))
    #         # remember_token = generate_token
    #         # self.update_attributes(:remember_digest, digest(remember_token))
    #     end

    #     def forget
    #         # update_attribute(:remember_digest, nil)
    #         update_attributes(:remember_digest, nil)
    #     end

    # end
    
    # Check if the given value matches the one stored in DB
    # def authenticated?(remember_token)
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

end