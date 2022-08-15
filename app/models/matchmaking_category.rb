class MatchmakingCategory < ApplicationRecord
    has_many :category_percentages, class_name: "category_percentage", foreign_key: "reference_id", :dependent => :destroy
    has_many :questions, class_name: "question", foreign_key: "reference_id", :dependent => :destroy
end
