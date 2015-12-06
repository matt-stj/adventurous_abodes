require "test_helper"

class OrdersTest < ActionDispatch::IntegrationTest
  test "user can see past orders" do
    create_orders
    order = Order.first
    visit orders_path

    assert page.has_content?("Order History")

    within(".cart-table") do
      assert page.has_content?("Order Number")
      assert page.has_content?("Total Price")
      assert page.has_content?("Date Ordered")

      assert page.has_content?(order.id)
    end
  end

  test "user can place an order and is redirected to the order history page" do
    checkout_user

    assert page.has_content?("Order History")
    assert_equal orders_path, current_path
  end

  test "authenticated user can see individual past orders" do
    checkout_user
    order = Order.first
    order_timestamp = order.created_at
    formatted_timestamp = "#{order_timestamp.strftime("%B %d, %Y")} at #{order_timestamp.strftime("%H:%M")}"

    visit orders_path

    click_link "View"
    assert_equal order_path(order), current_path

    assert page.has_content?("Sub-total")
    assert page.has_content?("Name")
    assert page.has_content?("Order status: Pending")
    assert page.has_content?("Total price")
    assert page.has_content?("Order submitted on #{formatted_timestamp}")
    assert page.has_content?("Last order status update: #{formatted_timestamp}")
    assert page.has_content?("Retired?")
  end

  test "user can access order history from user dashboard" do
    create_and_login_user

    click_link("Order History")
    assert_equal orders_path, current_path
  end
end
