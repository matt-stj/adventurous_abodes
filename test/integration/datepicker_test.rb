require "test_helper"

class DatepickerTest < ActionDispatch::IntegrationTest
  test "guest must supply a date for the datepicker" do
    create_rentals(1, "Castle")
    rental = RentalType.find_by_name("Castle").rentals.first
    visit rental_path(rental)
    click_link "Reserve it!"
    click_button "Place Order"

    assert page.has_content?("Reservations: 0")
    assert_equal "/cart_rentals/new", current_path
    assert page.has_content?("You must choose a start and end date")
  end

  test "guest must choose an end date that comes after the start date" do
    create_rentals(1, "Castle")
    rental = RentalType.find_by_name("Castle").rentals.first
    visit rental_path(rental)
    click_link "Reserve it!"
    fill_in "startDate", with: "Jan 01, 2016"
    fill_in "endDate",   with: "Dec 26, 2015"
    click_button "Place Order"

    assert page.has_content?("Reservations: 0")
    assert_equal "/cart_rentals/new", current_path
    assert page.has_content?("You must end your trip after the start date")
  end

  test "guest cannot overlap with another reservation" do
    checkout_user
    visit rental_path(Rental.last)
    click_link "Reserve it!"
    fill_in "startDate", with: "Dec 25, 2015"
    fill_in "endDate",   with: "Jan 02, 2016"
    click_button "Place Order"

    assert page.has_content?("Reservations: 0")
    assert_equal "/cart_rentals/new", current_path
    assert page.has_content?("You must checkout before the next reservation")
  end
end