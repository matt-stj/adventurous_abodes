class Order < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :rentals, through: :reservations

  def self.make_new(cart, current_user)
    order = current_user.orders.create(total: cart.total_cost)
    cart.ordered_rentals.each do |rental|
      order.reservations.create(rental_id: rental.rental_id,
                                 travellers: rental.travellers,
                                 price: rental.price)
    end
  end

  def update_status(status)
    update(status: status)
  end
end
