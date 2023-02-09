json.extract! user, :id, :email, :firstname, :lastname, :password, :roleID, :created_at, :updated_at
json.url user_url(user, format: :json)
