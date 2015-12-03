require "test_helper"

class OwnerOrdersTest < ActionDispatch::IntegrationTest
  def checkout_user_and_login_owner
    checkout_user(2)
    click_link "Logout"
    login_owner
  end

  test "owner can see all orders on dashboard" do
    checkout_user_and_login_owner
    visit owners_orders_path

    assert page.has_content?("Owner Order History")
  end

  test "owner can view an individual order" do
    checkout_user_and_login_owner

    assert owners_dashboard_path, current_path
    assert page.has_link?("Pending")
    click_link("Pending")

    assert_equal "/owners/orders/#{Order.first.id}", current_path
    # assert page.has_content?("#{Time.now.strftime("%B %d, %Y")}")
    assert page.has_content?("Total")
    assert page.has_content?("$0")
  end

  test "owner can update order status" do
    checkout_user_and_login_owner
    click_link "Pending"

    fill_in "Order status", with: "Completed"
    click_button "Update order status"

    assert page.has_content?("Completed")
    refute page.has_content?("Pending")
  end

  test "owner must update with a valid order status" do
    checkout_user_and_login_owner
    click_link "Pending"

    fill_in "Order status", with: "Bad Status"
    click_button "Update order status"

    assert page.has_content?("Invalid Order Status")
  end
end
