class Seeds
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_platform_admin
    seed.generate_owners
    seed.generate_registered_users
    seed.generate_rental_types
  end

  def generate_roles
    role_titles = %w(platform_admin store_admin registered_user)

    role_titles.each do |title|
      Role.create!(title: title)
    end
  end

  def generate_platform_admin
    platform_admin =  User.create!(username: "jorge@turing.io",  name: "Platform Admin",   password: "password")
    platform.roles  << Role.find_by_name(title: "platform_admin")
    puts "Platform Admin created!"
  end

  def generate_owners
    20.times do |i|
      name  = Faker::Name.name.first_name
      username = "andrew@turing.io"
      password = "password"
      image_url = Faker::Avatar.image
      user = User.create!(name: name,
                          username: username,
                          password: password,
                          image_url: image_url)
      user.roles << Role.find_by_name(title: "store_admin")
      puts "Owner #{i} created!"
    end
  end

  def generate_registered_users
    registered_user = User.create!(username: "josh@turing.io", name: "Registered User",       password: "password")
    registered_user.roles << Role.find_by_name(title: "registered_user")

    99.times do |i|
      name  = Faker::Name.name.first_name
      username = Faker::Internet.email(name)
      password = "password"
      image_url = Faker::Avatar.image
      user = User.create!(name:     name,
                   username: username,
                   password: password,
                   image_url: image_url)
      user.roles << Role.find_by_name(title: "registered_user")
      puts "Registered User #{i+1} created!"
    end
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
      puts "Rental Type #{i} created!"
    end
  end

  def generate_rentals
    50.times do |i|
      name  = Faker::Name.name.first_name + "'s " + rental_type
      description = Faker::Hipster.paragraph
      price = Faker::Commerce.price
      status = "active"
      image_file_name = ""
      image_content_type = ""
      image_file_size = ""
      image_updated_at = ""
      image = ""
      rental = Rental.create!(name: name,
                              description: description,
                              price: price,
                              status: status
                              image_file_name: image_file_name
                              image_content_type: image_content_type
                              image_file_size: image_file_size
                              image_updated_at: image_updated_at
                              image: image)
      puts "#{rental_type} #{i} created!"
    end
  end

  def generate_orders
    users = User.joins(:roles).where("title = ?", "platform_admin")
    users.each do |user|
      10.times do |i|
        status = "active"
        total = Faker::Commerce.price
        order = Order.create!(total: total,
                              status: status,
                              user_id: user.id)
        add_items(order)
        puts "Order #{i}: Order for #{user.name} created!"
      end
    end
  end

  private

    def add_items(order)
      2.times do |i|
        item = Rental.find(Random.new.rand(1..500))
        order.items << item
        puts "#{i}: Added item #{item.name} to order #{order.id}."
      end
    end
end
