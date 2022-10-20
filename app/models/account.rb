class Account < ApplicationRecord
    has_one :user_profile
    has_one :parent_profile
end