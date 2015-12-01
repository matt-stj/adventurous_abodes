class OrderedRental
  attr_reader :rental_id, :travellers, :price

  def initialize(rental_id, travellers, price)
    @rental_id = rental_id
    @travellers = travellers.abs
    @price = price
  end
end
