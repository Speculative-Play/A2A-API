class StarredMatchProfile < ApplicationRecord
    belongs_to :parent_profile,     class_name: "ParentProfile",    foreign_key: "parent_profile_id"
    belongs_to :match_profile,      class_name: "MatchProfile",     foreign_key: "match_profile_id"
end
