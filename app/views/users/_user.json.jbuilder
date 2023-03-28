<<<<<<< HEAD
json.extract! admin, :id, :email, :first_name, :last_name, :password,:documents_signed, :created_at, :updated_at
json.url user_url(admin, format: :json)
=======
json.extract! user, :id, :email, :firstname, :lastname, :password, :isRider, :isDriver, :isAdmin, :isTreasurer, :created_at, :updated_at
json.url user_url(user, format: :json)
>>>>>>> main
