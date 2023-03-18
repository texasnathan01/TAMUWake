Admin.create!([
    {email: "tamuwakeuser@gmail.com", full_name: "Admin User", uid: 123, avatar_url: "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg", is_approved: true}
])

User.create!([
    {email: "tamuwakeuser@gmail.com", firstname: "Admin", lastname: "User", password: "", documents_signed: true, role_id: 1}
])

WakeboardSet.create!([
    {
        driver_count: 1,
        scheduled_date: DateTime.current.tomorrow
    },
    {
        driver_count: 2,
        scheduled_date: DateTime.current.advance(days: 3)
    },
    {
        driver_count: 1,
        scheduled_date: DateTime.current.advance(days: 10)
    }
])


