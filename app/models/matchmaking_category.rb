class MatchmakingCategory < ApplicationRecord
    has_many :category_percentages, class_name: "category_percentage", foreign_key: "reference_id"
end
