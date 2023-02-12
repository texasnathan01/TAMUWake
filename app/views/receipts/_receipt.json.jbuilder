json.extract! receipt, :id, :user_id, :value, :date_made, :date_approved, :date_refunded, :stage, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
