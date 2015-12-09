class Order < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :rentals, through: :reservations

  STATUSES = ["Paid", "Cancelled", "Completed", "Pending"]
  validates :status, presence: :true, inclusion: {in: STATUSES}

  scope :pending, -> { where owner_status: 'Pending' }


  def self.owner_orders(owner)
    orders = []
    owner.rentals.each do |rental|
      rental_id = rental.id
      reservation = Reservation.find_by(rental_id: rental_id)
      order_id = reservation.order_id
      orders << Order.find(order_id)
    end
    orders
  end

  def self.make_new(cart, current_user)
    order = current_user.orders.create(total: cart.total_cost)
    cart.ordered_rentals.each do |rental|
      order.reservations.create(
          rental_id: rental.rental_id,
          price: rental.price,
          start_date: rental.start_date,
          end_date: rental.end_date
      )
    end
    order
  end

  def update_status(status)
    update(status: status)
  end
end
