require "test_helper"

class CartTest < ActiveSupport::TestCase
  attr_accessor :cart

  def setup
    @cart = Cart.new({})
    create_rental
    teardown
  end

  test "cart can store trips" do
    initial_count = @cart.total_trips
    @cart.add_trip(Rental.last.id, "21 December, 2015", "25 December, 2015")
    current_count = @cart.total_trips

    assert_equal 1, current_count - initial_count
  end

  test "cart can return total number of trips" do
    @cart.add_trip(Rental.last.id, "21 December, 2015", "25 December, 2015")
    total = @cart.total_trips

    assert_equal 1, total
  end

  test "cart can return total price of a trip" do
    skip
    @cart.add_trip(Rental.last.id, "21 December, 2015", "25 December, 2015")

    assert_equal 3000, @cart.total_cost
  end

  test "cart can remove trips" do
    rental = Rental.create(name: "Castle",
                           description: "Living it up like royalty",
                           price: 100,
                           id: @cart.trips.keys.first.to_i)
    @cart.add_trip(Rental.last.id, "21 December, 2015", "25 December, 2015")
    @cart.remove(rental)

    assert_equal 1, @cart.total_trips
  end

  test "cart can update trip start date" do
    rental = Rental.create(name: "N Castle",
                           description: "For Royalty only.",
                           price: 1000,
                           id: @cart.trips.keys.first.to_i)
    @cart.add_trip(Rental.first.id, "21 December, 2015", "25 December, 2015")
    @cart.update(rental.id, "27 December, 2015", "30 December, 2015")

    assert_equal "27 December, 2015", @cart.start_date(rental.id)
  end
end
