<<<<<<< HEAD
class User < ApplicationRecord
    has_many :wakeboard_set

    validates :first_name,:last_name,:email, presence: true
end
=======
class User < ApplicationRecord
    has_many :wakeboard_set
    has_one :rider

    validates :firstname,:lastname,:email, presence: true
end
>>>>>>> main
