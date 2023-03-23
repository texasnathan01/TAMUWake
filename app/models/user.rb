class User < ApplicationRecord
    has_many :wakeboard_set
    has_one :rider

    validates :first_name,:last_name,:email, presence: true
end
