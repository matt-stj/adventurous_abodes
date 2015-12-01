require "test_helper"

class AdminCanCreateRentalsTest < ActionDispatch::IntegrationTest
  test "admin can create rental" do
    login_admin

    click_link("Add Rental")

    assert_equal new_admin_rental_path, current_path
    assert page.has_content?("Add a New Rental")

    fill_in "Name", with: "Hiking in the Alps"
    fill_in "Description", with: "Have a ball hiking in the alps!"
    fill_in "Price", with: "1000"
    fill_in "Activity", with: "Hiking"
    click_button "Create Rental"

    assert_equal "/admin/rentals", current_path
    assert page.has_content?("The rental 'Hiking in the Alps' has been created")

    visit rentals_path
    assert page.has_content?("Hiking in the Alps")
  end

  test "user cannot access new rental path" do
    create_and_login_user
    visit new_admin_rental_path

    assert page.has_content?("The page you were looking for doesn't exist")
    refute page.has_content?("Add a New Rental")
  end
end
