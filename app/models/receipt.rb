class Receipt < ApplicationRecord
    validates :value,:date_made,:image_link, :user_id, presence: true
end
