class MatchmakingCategory < ApplicationRecord
    has_many :category_percentages, dependent: :destroy
    has_many :questions, dependent: :destroy
end
