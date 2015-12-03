require 'test_helper'

class GuestCanViewRentalsByOwnerTest < ActionDispatch::IntegrationTest
  test "guest can view rentals by owner" do
    create_roles
    owner = User.create(username: "owner", name: "Owner", password: "password")
    owner.roles << Role.find_by(title: "owner")

    2.times do |i|
      i += 1
      rental_type = RentalType.find_or_create_by(name: "Castle")
      rental_type.rentals.create(name: "Castle #{i}",
                               description: "No dragons allowed. #{i}",
                               price: 1000 + i)
      owner.rentals << Rental.last(i)
    end

    visit owner_path(owner)
    assert page.has_content?("Rentals")
    assert page.has_content?("Castle")
  end
end
