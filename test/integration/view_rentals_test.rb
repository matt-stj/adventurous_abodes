require "test_helper"

class ViewRentalsTest < ActionDispatch::IntegrationTest
  test "guest can view rentals" do
    create_rentals(1, "Castle")
    visit rentals_path

    assert page.has_content?("Rental")
    assert page.has_content?("Neuschwanstein 1")
    assert page.has_content?("$1,001")
  end

  test "guest can view rentals sorted by rental_type" do
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path
    click_link "Castle"

    assert_equal "/rental_types/castle", current_path
    assert page.has_content?("Neuschwanstein 1")
    refute page.has_content?("Igloo")
  end

  test "logged in user can view rentals" do
    create_and_login_user
    create_rentals(1, "Castle")
    visit rentals_path

    assert page.has_content?("Rental")
    assert page.has_content?("Neuschwanstein 1")
    assert page.has_content?("$1,001")
  end

  test "logged in user can view rentals sorted by rental_type" do
    create_and_login_user
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path
    click_link "Castle"

    assert_equal "/rental_types/castle", current_path
    assert page.has_content?("Neuschwanstein 1")
    refute page.has_content?("Igloo")
  end

  test "guest can view rentals by owner" do
    create_rentals(1, "Castle")
    visit owner_path(User.last)

    assert page.has_content?("Rentals")

    assert page.has_content?("Neuschwanstein 1")
  end

  test "logged in user cannot view rentals that have been retired" do
    create_and_login_user
    create_rentals(1, "Castle")
    Rental.last.retire
    visit rental_path(Rental.last)

    assert page.has_content?("This rental has been retired and may no longer be purchased.")
    refute page.has_content?("Purchase Trip")
  end
end
