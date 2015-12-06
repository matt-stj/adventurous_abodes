require "test_helper"

class ViewOrdersTest < ActionDispatch::IntegrationTest
  test "a logged in user can view past orders" do
    checkout_user
    visit orders_path
    order_id = Order.first.id

    assert page.has_content?("Order History")
    assert page.has_content?(order_id)
  end
end
