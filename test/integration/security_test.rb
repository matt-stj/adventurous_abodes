require "test_helper"

class SecurityTest < ActionDispatch::IntegrationTest
  test "unathenticated user cannot see another users dashboard" do
    visit login_path

    fill_in "Username", with: "Nicole"
    fill_in "Password", with: "pass"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Login")
  end

  test "unathenticated user cannot see another users orders" do
    checkout_user
    click_link "Logout"

    User.create(name: "Torie", username: "tjw", password: "password")
    visit login_path
    fill_in "Username", with: "tjw"
    fill_in "Password", with: "password"
    click_button "Login"

    other_users_order_id = Order.first.id

    visit order_path(other_users_order_id)

    assert page.has_content?("Back Off")
  end

  test "unathenticated user is redirected to login page when they try checkout" do
    add_item_to_cart
    visit "/cart"
    click_button "Checkout"

    assert_equal login_path, current_path
    assert page.has_content?("Login to Your Account")
  end

  test "authenticated user cannot access another users dashboard" do
    User.create(name: "Nicole", username: "cole", password: "password")
    User.create(name: "Torie", username: "torie", password: "pass")

    visit login_path

    fill_in "Username", with: "cole"
    fill_in "Password", with: "pass"
    click_button "Login"

    assert_equal "/login", current_path
  end

  test "authenticated user cannot access owner dashboard and create/update/delete trips" do
    create_and_login_user

    refute page.has_content?("Owner Dashboard")
    refute page.has_content?("Create Rentals")
    refute page.has_content?("Edit Rentals")
    refute page.has_content?("Delete Rentals")
  end
end
