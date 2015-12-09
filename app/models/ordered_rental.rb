class OrderedRental
  attr_reader :rental_id, :price, :start_date, :end_date

  def initialize(rental_id, price, start_date, end_date)
    @rental_id  = rental_id
    @price      = price
    @start_date = start_date
    @end_date   = end_date
  end
end
