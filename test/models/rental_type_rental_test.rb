require 'test_helper'

class RentalTypeRentalTest < ActiveSupport::TestCase
  test "rentals are linked to rental_types" do
    hiking = RentalType.create(name: "hiking")

    rental_in_germany = Rental.create(name: "hiking in the alps", description: "hike the alps!", rental_type_id: hiking.id)
    rental_in_mexico = Rental.create(name: "hike the Pico de Orizaba", description: "hike in mexico!", rental_type_id: hiking.id)

    assert_equal "hiking", rental_in_germany.rental_type.name
  end
end
