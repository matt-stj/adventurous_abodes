require "test_helper"

class CheckoutTest < ActionDispatch::IntegrationTest
  test "user must be logged in to checkout" do
    add_item_to_cart
    visit "/cart"
    click_button "Checkout"

    assert page.has_content?("You must be logged in to checkout")
    assert_equal login_path, current_path
  end

  test "logged in user can checkout" do
    checkout_user

    assert_equal "/orders", current_path
    assert page.has_content?("Order was successfully placed")
  end

  test "user can't checkout with no items in cart" do
    create_and_login_user
    visit "/cart"

    assert page.has_content?("No items in cart.")
  end
end
