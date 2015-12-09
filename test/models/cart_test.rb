require "test_helper"

class CartTest < ActiveSupport::TestCase
  attr_accessor :cart

  def setup
    @cart = Cart.new({})
  end

  def add_trips_to_cart(num, start_date, end_date)
    num.times do |i|
      @cart.add_trip(i, start_date, end_date)
    end
  end

  test "cart can store trips" do
    initial_count = @cart.total_trips
    @cart.add_trip(3, "21 December, 2015", "25 December, 2015")
    current_count = @cart.total_trips

    assert_equal 1, current_count - initial_count
  end

  test "cart can return total number of trips" do
    add_trips_to_cart(5, "21 December, 2015", "25 December, 2015")
    total = @cart.total_trips

    assert_equal 5, total
  end

  test "cart can remove trips" do
    add_trips_to_cart(1, "21 December, 2015", "25 December, 2015")
    rental = Rental.create(name: "Castle",
                           description: "Living it up like royalty",
                           price: 100,
                           id: @cart.trips.keys.first.to_i)
    original_total = @cart.total_trips
    @cart.remove(rental)
    current_total = @cart.total_trips

    assert_equal 1, original_total - current_total
  end

  test "cart can update trip start date" do
    add_trips_to_cart(2, "21 December, 2015", "25 December, 2015")
    rental = Rental.create(name: "N Castle",
                           description: "For Royalty only.",
                           price: 1000,
                           id: @cart.trips.keys.first.to_i)
    @cart.update(rental.id, "27 December, 2015", "30 December, 2015")

    assert_equal "27 December, 2015", @cart.start_date(rental.id)
  end
end
