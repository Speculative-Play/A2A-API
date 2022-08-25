class UserProfile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # could also use: 
    # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}

    has_one :parent_account, dependent: :destroy
    has_many :starred_match_profiles, through: :parent_account, dependent: :destroy
    has_many :user_question_answers, dependent: :destroy
    has_many :category_percentages, dependent: :destroy

    # has_secure_password
    has_one_attached :image, dependent: :destroy
end
