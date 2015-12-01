require 'test_helper'

class ActivityRentalTest < ActiveSupport::TestCase
  test "rentals are linked to activities" do
    hiking = Activity.create(name: "hiking")

    rental_in_germany = Rental.create(name: "hiking in the alps", description: "hike the alps!", activity_id: hiking.id)
    rental_in_mexico = Rental.create(name: "hike the Pico de Orizaba", description: "hike in mexico!", activity_id: hiking.id)

    assert_equal "hiking", rental_in_germany.activity.name
  end
end
