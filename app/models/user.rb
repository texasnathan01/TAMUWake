class User < ApplicationRecord
    has_many :wakeboard_set
    has_one :rider

    validates :firstname,:lastname,:email, presence: true
end
