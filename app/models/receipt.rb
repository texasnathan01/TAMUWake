class Receipt < ApplicationRecord
    validates :value, :date_made, :image_link, :admin_id, presence: true
end
