class Account < ApplicationRecord
    belongs_to :user_profile,   optional: true
    belongs_to :parent_profile, optional: true
end