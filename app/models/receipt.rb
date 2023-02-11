class Receipt < ApplicationRecord
    validates :driver, presence: true
end
