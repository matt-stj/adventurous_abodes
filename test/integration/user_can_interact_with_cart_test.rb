require "test_helper"

class UserCanInteractWithCartTest < ActionDispatch::IntegrationTest
  test "user can add item to cart" do
    create_rentals(1, "Hiking")
    rental = RentalType.find_by_name("Hiking").rentals.first
    visit rental_path(rental)

    assert page.has_content?("Trips: 0")

    click_link "Purchase Trip"

    assert_equal new_cart_rental_path, current_path

    fill_in "travellers", with: 2
    click_button "Place Order"

    assert page.has_content?("Trips: 1")
    assert_equal rentals_path, current_path
    assert page.has_content?("You have added Hiking the Alps 1 to your cart.")
  end

  test "user can view cart" do
    visit rentals_path
    add_items_to_cart(2)
    click_link "Trips: 2"

    assert_equal "/cart", current_path

    assert page.has_content?("Hiking the Alps 1")
    assert page.has_content?("Go hike the alps! 1")
    assert page.has_content?("$1,001")

    assert page.has_content?("Total: $3,003")
  end

  test "user can delete item from cart" do
    add_items_to_cart(1)
    removed_rental = Rental.find_by_name("Hiking the Alps 1")
    visit "/cart"

    within(".rental_card") do
      click_button("Remove")
    end

    assert_equal "/cart", current_path
    assert page.has_content?("You have removed the trip Hiking the Alps 1 from your cart.")
    assert page.has_content?("No items in cart.")

    click_link("Hiking the Alps 1")
    assert_equal rental_path(removed_rental), current_path
  end

  test "user can edit the number of travellers in cart" do
    add_items_to_cart(1)
    click_link "Trips: 1"

    assert_equal "/cart", current_path
    assert page.has_content?("Hiking the Alps 1")
    assert page.has_content?("$1,001")

    assert_equal "/cart", current_path
    fill_in "travellers", with: 5
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content?("$5,005")

    assert_equal "/cart", current_path
    fill_in "travellers", with: 2
    click_button "Update"

    assert_equal "/cart", current_path
    assert page.has_content?("$2,002")
  end

  test "user can view items in cart after they log back in" do
    add_items_to_cart(2)
    create_and_login_user

    assert page.has_content?("Trips: 2")
    click_link "Logout"
    assert page.has_content?("Login")
    refute page.has_content?("Logout")
  end

  test "if user adds negative number of travellers the absolute value is taken instead" do
    create_rentals(1, "Hiking")
    create_and_login_user

    rental = RentalType.find_by_name("Hiking").rentals.first
    visit rental_path(rental)

    click_link "Purchase Trip"
    fill_in "travellers", with: -2
    click_button "Place Order"

    visit "/cart"
    click_button "Checkout"

    refute page.has_content?("-2")
    refute page.has_content?("-$2,002")
  end
end
