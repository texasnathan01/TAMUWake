User.create!([
  {email: "chrispasala@tamu.edu", firstname: "Christopher", lastname: "Pasala", password: "test", isRider: true, isDriver: true, isAdmin: false, isTreasurer: false},
  {email: "christopher@gmail.com", firstname: "pasala", lastname: "chr", password: "test", isRider: false, isDriver: false, isAdmin: true, isTreasurer: true},
  {email: "test@gmail.com", firstname: "test", lastname: "test", password: "test", isRider: true, isDriver: false, isAdmin: false, isTreasurer: false},
  {email: "new@gmail.com", firstname: "new", lastname: "new", password: "new", isRider: false, isDriver: false, isAdmin: true, isTreasurer: false},
  {email: "hi@gmail.com", firstname: "hi", lastname: "hi", password: "bye", isRider: true, isDriver: false, isAdmin: false, isTreasurer: false}
])

Role.create!([
  {role_id: 0, role_name: "Rider"},
  {role_id: 1, role_name: "Driver"},
  {role_id: 2, role_name: "Treasurer"},
  {role_id: 3, role_name: "Admin"}
])
