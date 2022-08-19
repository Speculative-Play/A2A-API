class UserProfile < ApplicationRecord
    before_save { self.username = username.downcase }
    has_one :parent_account, dependent: :destroy
    has_many :starred_match_profiles, through: :parent_account, dependent: :destroy
    has_many :user_question_answers, class_name: "user_question_answers", foreign_key: "reference_id", dependent: :destroy
    has_many :category_percentages, class_name: "category_percentage", foreign_key: "reference_id", dependent: :destroy
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 15 }
    has_secure_password
    has_one_attached :image, dependent: :destroy
end
