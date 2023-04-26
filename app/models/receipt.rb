class Receipt < ApplicationRecord
    belongs_to :admin

    validates :value, :date_made, :image_link, :admin_id, presence: true
end
