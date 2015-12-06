class Order < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :rentals, through: :reservations

  scope :pending, -> { where owner_status: 'pending' }

  def self.owner_orders(owner)
    binding.pry
    owner.orders
  end

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
