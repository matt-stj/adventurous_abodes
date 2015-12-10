require "test_helper"

class OwnerOrdersTest < ActionDispatch::IntegrationTest
  test "owner can see all their orders on dashboard" do
    checkout_user
    order_id = Order.first.id
    click_link "Logout"
    visit login_path
    fill_in "Username", with: "owner0"
    fill_in "Password", with: "password"
    click_button "Login"
    visit owners_orders_path

    assert page.has_content?("Owner Order History")
    assert page.has_content?(order_id)
  end

  test "owner can view and update an individual order" do
    checkout_user
    Order.first.id
    click_link "Logout"
    visit login_path
    fill_in "Username", with: "owner0"
    fill_in "Password", with: "password"
    click_button "Login"
    visit owners_orders_path
    click_link "View"
    assert page.has_content?("Pending")
    select("Completed", :from => 'order[status]')
    click_button "Update Status"

    assert page.has_content?("Completed")
  end

  test "owner must update an order with correct " do
    checkout_user
    Order.first.id
    click_link "Logout"
    visit login_path
    fill_in "Username", with: "owner0"
    fill_in "Password", with: "password"
    click_button "Login"
    visit owners_orders_path
    click_link "View"
    assert page.has_content?("Pending")
    select("Completed", :from => 'order[status]')
    click_button "Update Status"

    assert page.has_content?("Completed")
  end

  test "owner does not see orders of other owners" do
    checkout_user
    order_id = Order.first.id
    click_link "Logout"
    create_owners(2, "active")
    visit login_path
    fill_in "Username", with: "owner1"
    fill_in "Password", with: "password"
    click_button "Login"
    visit owners_orders_path

    assert page.has_content?("Owner Order History")
    refute page.has_link?(order_id)
  end
end
