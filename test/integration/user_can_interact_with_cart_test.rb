require "test_helper"

class UserCanInteractWithCartTest < ActionDispatch::IntegrationTest
  test "guest can add item to cart" do
    create_rentals(1, "Castle")
    rental = RentalType.find_by_name("Castle").rentals.first
    visit rental_path(rental)
    assert page.has_content?("Trips: 0")
    click_link "Purchase Trip"

    assert_equal new_cart_rental_path, current_path
    click_button "Place Order"

    assert page.has_content?("Trips: 1")
    assert_equal rentals_path, current_path
    assert page.has_content?("You have added Castle 1 to your cart.")
  end

  test "guest can view cart" do
    visit rentals_path
    add_items_to_cart(2)
    click_link "Trips: 2"

    assert_equal "/cart", current_path
    assert page.has_content?("Castle")
    assert page.has_content?("Price: $1,001")
  end

  test "guest can delete item from cart" do
    add_items_to_cart(1)
    removed_rental = Rental.find_by_name("Castle 1")
    visit "/cart"

    click_button("Remove")

    assert_equal "/cart", current_path
    assert page.has_content?("You have removed the trip Castle 1 from your cart.")
    assert page.has_content?("No items in cart.")

    click_link("Castle 1")
    assert_equal rental_path(removed_rental), current_path
  end

  test "guest can view items in cart after logging in" do
    add_items_to_cart(2)
    visit '/cart'
    click_button("Checkout")

    @user = create_user
    fill_in "Username", with: @user.username
    fill_in "Password", with: "password"
    click_button "Login"
    visit '/cart'

    assert page.has_content?("Trips: 2")
  end

end
