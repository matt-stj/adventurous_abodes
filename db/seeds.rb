Role.create!(title: "platform_admin")
Role.create!(title: "store_admin")
Role.create!(title: "registered_user")

rental_types = ["Castle",
                "Dungeon",
                "Shack",
                "Treehouse",
                "Penthouse",
                "Spaceship",
                "Submarine",
                "Mansion",
                "Capsule",
                "Igloo",
                "Attic",
                "Storage Container"]

rental_types.each do |rental_type|
  RentalType.create!(name: "#{rental_type}")
end

Rental.create!(name: "Castle Rental",  description: "Live it up like Royalty!",     price: 150,  rental_type_id: RentalType.first.id)
Rental.create!(name: "Dungeon Rental 1", description: "For the coder in your life.",  price: 750,  rental_type_id: RentalType.second.id)
Rental.create!(name: "Dungeon Rental 2", description: "For the coder in your life.",  price: 750,  rental_type_id: RentalType.second.id)
Rental.create!(name: "Dungeon Rental 3", description: "For the coder in your life.",  price: 750,  rental_type_id: RentalType.second.id)
Rental.create!(name: "Shack Rental",   description: "When amenities don't matter.", price: 1150, rental_type_id: RentalType.third.id)

User.create!(username: "shannon", name: "Shannon", password: "pass")
User.create!(username: "michael", name: "Michael", password: "pass")
User.create!(username: "matt",    name: "Matt",    password: "pass")
User.create!(username: "cole",    name: "Cole",    password: "pass")
User.create!(username: "owner",   name: "Owner",   password: "pass", role: 1)

Order.create!(user_id: 1, status: "Completed", total: 1000,  created_at: "2015-10-18 21:56:18", updated_at: "2015-10-18 21:56:18")
Order.create!(user_id: 2, status: "Paid",      total: 10000, created_at: "2015-09-18 21:56:18", updated_at: "2015-09-18 21:56:18")
Order.create!(user_id: 3, status: "Cancelled", total: 8000,  created_at: "2015-11-18 21:56:18", updated_at: "2015-11-18 21:56:18")
Order.create!(user_id: 4, status: "Pending",   total: 3000,  created_at: "2015-08-18 21:56:18", updated_at: "2015-08-18 21:56:18")
