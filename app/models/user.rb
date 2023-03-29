class User < ApplicationRecord
    has_many :wakeboard_set
    has_many :set_role

    validates :firstname,:lastname,:email, presence: true
end
