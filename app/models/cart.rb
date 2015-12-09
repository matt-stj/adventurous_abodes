class Cart
  attr_reader :trips

  def initialize(raw_data)
    @trips = raw_data || {}
  end

  def add_trip(rental_id, start_date, end_date, nights)
    trips[rental_id.to_s] = {start_date: start_date, end_date: end_date, nights: nights}
  end

  def total_trips
    trips.to_a.count
  end

  def count_of(rental_id)
    trips[rental_id.to_s]
  end

  def start_date(rental_id)
    trips[rental_id.to_s][:start_date]
  end

  def remove(rental)
    trips.delete(rental.id.to_s)
  end

  def update(rental_id, start_date, end_date)
    trips[rental_id.to_s] = {start_date: start_date, end_date: end_date}
  end

  def ordered_rentals
    trips.map do |rental_id, _, _|
      rental = Rental.find(rental_id.to_i)
      OrderedRental.new(rental_id, rental.price)
    end
  end

  def rentals_in_cart
    trips.map do |trip_id, dates|
      [Rental.find(trip_id.to_i), dates["start_date"], dates["end_date"], dates["nights"]]
    end
  end

  def total_cost
    6006
    #prices = rentals_in_cart.reduce([]) do |
  end
end
