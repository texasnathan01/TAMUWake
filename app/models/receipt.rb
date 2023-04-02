class Receipt < ApplicationRecord
	
	validates :value,:date_made,:image_link, presence: true
end
