require 'test_helper'

class RentalTypeTest < ActiveSupport::TestCase
  test "any rental_type can be created" do
    rental_type = RentalType.create(name: "House")
    assert rental_type.valid?
  end

  test "active_rentals returns a rentals active rentals" do
    rental_type = RentalType.create(name: "Castle")

    assert 0, rental_type.active_rentals.count

    rental = Rental.new(description: "No Dragons allowed!",
                        price: 1001,
                        rental_type_id: RentalType.find_by_name("Castle").id,
                        status: "active")

    assert 1, rental_type.active_rentals.count
  end

  test "active_rentals doesn't return a rentals inactive rentals" do
    rental_type = RentalType.create(name: "Castle")

    assert 0, rental_type.active_rentals.count

    rental = Rental.new(description: "No Dragons allowed!",
                        price: 1001,
                        rental_type_id: RentalType.find_by_name("Castle").id,
                        status: "inactive")

    assert 0, rental_type.active_rentals.count
  end
end
