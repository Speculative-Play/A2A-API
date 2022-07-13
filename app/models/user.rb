class User < ApplicationRecord
    before_save { self.username = username.downcase }
    has_one :profile, dependent: :destroy
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 15 }
    has_secure_password
end
