class Seed

  def self.start
    seed = Seed.new
    seed.remove_old_images
    seed.generate_rental_types
    seed.generate_rentals
    seed.generate_roles
    seed.generate_platform_admin
    seed.generate_owners
    seed.generate_registered_users
    seed.add_rental_properties_to_owners
    seed.generate_reservations
  end

  def remove_old_images
    p "old system directory succesfully removed" if FileUtils.rm_rf('public/system')
  end

  def generate_rental_types
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
      RentalType.create!(name: rental_type)
      puts "Rental Type #{rental_type} created!"
    end
  end

  def generate_random_image(rental_type)
    rental_type_array = []
      Dir.foreach("app/assets/images/#{rental_type}") do |item|
        next if /^[.]/.match(item)
        rental_type_array << "app/assets/images/#{rental_type}/#{item}"
      end
    rental_type_array.sample
  end

  def generate_rentals(num=50)
    rental_types = RentalType.all
    rental_types.each do |rental_type|
      (num).times do |i|
        name  = "#{Faker::Company.buzzword.capitalize} #{rental_type.name}"
        description = Faker::Lorem.paragraph
        price = Faker::Commerce.price + 1
        english_butler =        ["He's here to serve!",
                                 "You'll have to do it yourself"].sample
        onsite_masseuse =       ["We'll get your knots worked out",
                                 "Apologies, but no masseuse on staff"].sample
        private_movie_theater = ["Watch a movie in style. We even have fresh popcorn!",
                                  "No movie theater here. But who goes to the movies on vacation?"].sample
        elite_golf_course =     ["Tell your friends you shot a 72 on our private golf course",
                                 "Sorry, no golf. But golf's for old men anyway"].sample
        in_house_pet_psychic =  ["Our pet psychic is on call 24 hours a day",
                                 "We are between pet psychics right now"].sample
        results_oriented_gym =  ["Feel the burn and see immediate results",
                                 "No onsite gym. You are perfect just as you are"].sample
        luxury_private_jet =    ["Our private jet is fueled up and ready for departure",
                                 "Our jet is in the shop"].sample
        olympic_pool =          ["Our Olympic-size swimming pool is heated and has a diving board",
                                 "We do not have a swimming pool because the chlorine will turn your hair green"].sample
        status = "active"
        image = File.open(generate_random_image(rental_type.name.parameterize))

        rental_type.rentals.create!(name: name,
                                            description: description,
                                            price: price,
                                            english_butler: english_butler,
                                            onsite_masseuse: onsite_masseuse,
                                            private_movie_theater: private_movie_theater,
                                            elite_golf_course: elite_golf_course,
                                            results_oriented_gym: results_oriented_gym,
                                            luxury_private_jet: luxury_private_jet,
                                            olympic_pool: olympic_pool,
                                            in_house_pet_psychic: in_house_pet_psychic,
                                            status: status,
                                            image: image)
        puts "#{rental_type} #{i+1} created!"
      end
    end
  end

  def generate_roles
    role_titles = %w(platform_admin owner registered_user)

    role_titles.each do |title|
      Role.create!(title: title)
    end
  end

  def generate_platform_admin
    platform_admin =  User.create!(username: "jorge@turing.io",  name: "Platform Admin",   password: "password")
    platform_admin.roles  << Role.find_by(title: "platform_admin")
    puts "Platform Admin created!"
  end

  def generate_owners
    owner_role = Role.find_by(title: "owner")
    300.times do |i|
      name  = Faker::Name.first_name
      username = "andrew#{i}@turing.io"
      password = "password"
      image_url = Faker::Avatar.image
      owner = User.create!(name: name,
                          username: username,
                          password: password,
                          image_url: image_url,
                          owner_status: "active")
      owner.roles << owner_role
      puts "Owner #{i+1} created!"
    end
  end

  def generate_registered_users
    registered_user = User.create!(username: "josh@turing.io", name: "Registered User",       password: "password")
    registered_user.roles << Role.find_by(title: "registered_user")
    puts "Registered User 1 created!"

    registered_user = Role.find_by(title: "registered_user")
    99.times do |i|
      name  = Faker::Name.first_name
      username = Faker::Internet.email(name)
      password = "password"
      image_url = Faker::Avatar.image
      user = User.create!(name:     name,
                   username: username,
                   password: password,
                   image_url: image_url)
      user.roles << registered_user
      puts "Registered User #{i+2} created!"
    end
  end



  def add_rental_properties_to_owners
    j = 1
    owners = User.joins(:roles).where("title = ?", "owner")
    owners.each do |owner|
      rental_one = Rental.find(j)
      rental_two = Rental.find(j+1)
      owner.rentals << rental_one
      owner.rentals << rental_two
      j += 2
      puts "Added 2 rentals to #{owner.name}"
    end
  end

  def generate_reservations
    users = User.joins(:roles).where("title = ?", "registered_user")
    users.each do |user|
      10.times do |i|
        status = "Pending"
        total = Faker::Commerce.price
        order = user.orders.create!(total: total, status: status)
        add_rentals(order)
        puts "Order #{i+1}: Order for #{user.name} created!"
      end
    end
  end

  private

    def add_rentals(order)
      2.times do |i|
        rental = Rental.find(Random.new.rand(1..550))
        rental_id = rental.id
        order_id = order.id
        create_reservation(order_id, rental_id)
        puts "Added rental to order #{i}."
      end
    end

    def create_reservation(order_id, rental_id)
      start_date = Date.today
      while Reservation.find_by(rental_id: rental_id, start_date: start_date) do
        start_date = start_date + 1.day
      end
      Reservation.create!(order_id: order_id,
                          rental_id: rental_id,
                          start_date: start_date,
                          end_date: start_date + 1.day)
    end
end

Seed.start
