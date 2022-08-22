class StarredMatchProfile < ApplicationRecord
    belongs_to :parent_account, class_name: "ParentAccount", foreign_key: "parent_account_id"
    belongs_to :match_profile, class_name: "MatchProfile", foreign_key: "match_profile_id"
end
