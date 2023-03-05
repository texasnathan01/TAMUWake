json.extract! user, :id, :email, :firstname, :lastname, :password, :isRider, :isDriver, :isAdmin, :isTreasurer, :created_at, :updated_at
json.url user_url(user, format: :json)
