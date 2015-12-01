require 'test_helper'

class RentalTypeTest < ActiveSupport::TestCase
  test "an rental_type can be creted" do
    rental_type = RentalType.new(name: "Hiking")
    assert rental_type.valid?
  end
end
