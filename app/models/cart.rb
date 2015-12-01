class Cart
  attr_reader :trips

  def initialize(raw_data)
    @trips = raw_data || {}
  end

  def add_trip(rental_id)
    trips[rental_id.to_s] ||= 0
    trips[rental_id.to_s] += 1
  end

  def total_trips
    trips.to_a.count
  end

  def count_of(rental_id)
    trips[rental_id.to_s]
  end

  def remove(rental)
    trips.delete(rental.id.to_s)
  end

  def update(rental_id, travellers)
    trips[rental_id] = travellers.to_i.abs
  end

  def ordered_rentals
    trips.map do |rental_id, travellers|
      rental = Rental.find(rental_id.to_i)
      OrderedRental.new(rental_id, travellers, rental.price)
    end
  end

  def rentals_in_cart
    trips.keys.map { |trip_id| Rental.find(trip_id.to_i) }
  end

  def total_cost
    prices = rentals_in_cart.reduce([]) do |prices, rental|
      prices << (rental.price * trips[rental.id.to_s]).abs
    end
    prices.sum
  end
end
