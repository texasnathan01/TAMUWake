class Receipt < ApplicationRecord
	
	validates :value,:date_made,:image_link, presence: true

	def self.search(search)
		if search
			receipt_ret = Receipt.find_by(value: search)
				if(receipt_ret)
					self.where(receipt_id: receipt_ret)
				else
					@receipts = Receipts.all
				end
		else
			@receipts = Receipt.all
		end
	end
end
