class User < ApplicationRecord
    has_many :wakeboard_set

    validates :first_name,:last_name,:email, presence: true
end
