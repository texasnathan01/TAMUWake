json.extract! admin, :id, :email, :first_name, :last_name, :password,:documents_signed, :created_at, :updated_at
json.url user_url(admin, format: :json)
