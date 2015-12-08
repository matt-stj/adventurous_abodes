require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  def valid_attributes
    {
      travellers: 2,
      price: 1001
    }
  end

  test "a valid ordered trip can be created" do
    reservation = Reservation.new(valid_attributes)
    assert reservation.valid?
  end
end
