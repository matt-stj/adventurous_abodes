require "test_helper"

class ViewOrdersTest < ActionDispatch::IntegrationTest
  test "a logged in user can view past orders" do
    create_orders
    visit orders_path

    assert page.has_content?("Order History")
    assert page.has_content?("$1,001")
  end

  test "a logged in owner can view past orders" do
    skip
    create_and_login_owner
    add_items_to_cart(1)
    visit "/cart"
    click_button "Checkout"
    visit orders_path

    assert page.has_content?("Order History")
    assert page.has_content?("$0")
  end
end
