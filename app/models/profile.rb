class Profile < ApplicationRecord
    # validates :name, :age, :gender, :location, presence: true
    # validates :cultureScore, :facialScore, numeric: { greater_than: 0, less_than: 100 }
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_many :answers, class_name: "Answer", foreign_key: "answer_id"
end
