require "test_helper"

class ViewRentalsTest < ActionDispatch::IntegrationTest
  test "guest can view rental types page" do
    RentalType.create(name: "Treehouse")
    visit "/"
    click_button "View Rental Properties"

    assert_equal rental_types_path, current_path
    assert page.has_content?("Rental Types")
    assert page.has_content?("Treehouse")
  end

  test "registered user can view rental types page" do
    create_and_login_user
    RentalType.create(name: "Treehouse")
    visit "/"
    click_button "View Rental Properties"

    assert_equal rental_types_path, current_path
    assert page.has_content?("Rental Types")
    assert page.has_content?("Treehouse")
  end

  test "visitor can view rentals" do
    create_rentals(2, "Castle")
    visit rentals_path

    within("h1") do
      assert page.has_content?("Rental")
    end

    within("#castle_1") do
      assert page.has_content?("Castle 1")
      assert page.has_content?("$1,001")
    end

    within("#castle_2") do
      assert page.has_content?("Castle 2")
      assert page.has_content?("$1,002")
    end
  end

  test "visitor can see rentals sorted by rental_types" do
    create_rentals(2, "Castle")
    create_rentals(2, "Igloo")
    visit rental_types_path
    click_link "Castle"

    assert_equal "/rental_types/castle", current_path
    within("h1") do
      assert page.has_content?("Castle")
      refute page.has_content?("Igloo")
    end
  end
end
