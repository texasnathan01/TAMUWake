class Role < ApplicationRecord
    has_many :set_role
    has_many :user
end
