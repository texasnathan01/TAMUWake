class User < ApplicationRecord
    validates :firstname,:lastname,:email presence: true
end
