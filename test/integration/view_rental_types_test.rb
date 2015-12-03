require "test_helper"

class ViewRentalTypesTest < ActionDispatch::IntegrationTest
  test "guest can view rental types page" do
    create_rentals(2, "Castle")
    visit "/"
    click_button "View Rental Properties"

    assert_equal rental_types_path, current_path
    assert page.has_content?("Rental Types")
    assert page.has_content?("Castle")
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
end
