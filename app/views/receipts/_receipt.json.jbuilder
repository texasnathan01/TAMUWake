json.extract! receipt, :id, :value, :driver, :date, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
