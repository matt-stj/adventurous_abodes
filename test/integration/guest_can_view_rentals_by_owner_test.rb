require 'test_helper'

class GuestCanViewRentalsByOwnerTest < ActionDispatch::IntegrationTest
  test "guest can view rentals by owner" do
    owner = User.create!(username: "owner", name: "owner", password: "password", role: 1)

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
