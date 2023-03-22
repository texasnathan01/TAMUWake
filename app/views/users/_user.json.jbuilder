json.extract! user, :id, :email, :firstname, :lastname, :password, :isRider, :isDriver, :isAdmin, :isTreasurer, :uin, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
