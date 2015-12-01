module OrdersHelper
  def order_rentals_list(order)
    rentals = rentals_names_and_travellers(order)
    rentals.join(",  <br>")
  end

  def rentals_names_and_travellers(order)
    order.rentals.map { |rental| format_name_and_travellers(order, rental) }
  end

  def rental_name_and_travellers(order, target_rental)
    rental_name = order.rentals.map do |rental|
      next unless target_rental.id.to_i == rental.id
      format_name_and_travellers(order, rental)
    end
    rental_name.compact[0]
  end

  def format_name_and_travellers(order, rental)
    num_travellers = OrderedTrip.find_by(rental_id: rental.id, order_id: order.id).travellers
    "#{rental.name} (Travellers: #{num_travellers || 1})"
  end

  def filter_by_status
    Order.all.each { |order| order.status == "#{status}" }
  end
end
