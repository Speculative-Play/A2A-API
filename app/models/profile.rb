class Profile < ApplicationRecord
    # validates :name, :age, :gender, :location, presence: true
    # validates :cultureScore, :facialScore, numeric: { greater_than: 0, less_than: 100 }
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_many :user_answers, class_name: "user_answer", foreign_key: "user_answer_id"
end
