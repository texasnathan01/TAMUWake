class User < ApplicationRecord
    has_many :wakeboard_set
    has_many :set_role

    validates :first_name,:last_name,:email, presence: true
end
