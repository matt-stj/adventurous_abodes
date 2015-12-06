class OrderedRental
  attr_reader :rental_id, :price

  def initialize(rental_id, price)
    @rental_id = rental_id
    @price = price
  end
end
