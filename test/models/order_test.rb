require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "an order with a status of Pending is valid" do
    user = create_user
    order = Order.create(user_id: user.id, status: "Pending", total: 32)

    assert order.valid?
  end

  test "an order with a status of Cancelled is valid" do
    user = create_user
    order = Order.create(user_id: user.id, status: "Cancelled", total: 32)

    assert order.valid?
  end

  test "an order with a status of Paid is valid" do
    user = create_user
    order = Order.create(user_id: user.id, status: "Paid", total: 32)

    assert order.valid?
  end

  test "an order with a status of Completed is valid" do
    user = create_user
    order = Order.create(user_id: user.id, status: "Completed", total: 32)

    assert order.valid?
  end

  test "an order without a status of Paid, Cancelled, Pending or Completed is invalid" do
    user = create_user
    order = Order.create(user_id: user.id, status: "BadStatus", total: 32)

    refute order.valid?
  end
end
