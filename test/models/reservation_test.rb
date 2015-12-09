require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  def valid_attributes
    {
      price:      1001,
      start_date: Date.today,
      end_date:   Date.tomorrow
    }
  end

  test "a valid ordered trip can be created" do
    reservation = Reservation.new(valid_attributes)

    assert reservation.valid?
  end

  test "a reservation can calculate number of nights" do
    reservation = Reservation.new(valid_attributes)

    assert_equal 1, reservation.number_of_nights
  end
end
