require "test_helper"

class ViewRentalTypesTest < ActionDispatch::IntegrationTest
  test "guest can view rental types page" do
    create_rentals(2, "Castle")
    visit "/"
    click_button "Search All Rentals"

    assert_equal rental_types_path, current_path

    assert page.has_content?("Rentals")
  end

  test "registered user can view rental types page" do
    create_and_login_user
    visit "/"
    click_button "Search All Rentals"

    assert_equal rental_types_path, current_path

    assert page.has_content?("Rentals")
  end
end
