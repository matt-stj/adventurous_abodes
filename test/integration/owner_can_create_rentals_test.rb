require "test_helper"

class OwnerCanCreateRentalsTest < ActionDispatch::IntegrationTest
  test "owner can create rental" do
    skip
    login_owner

    click_link("Add Rental")

    assert_equal new_owner_rental_path, current_path
    assert page.has_content?("Add a New Rental")

    fill_in "Name", with: "Hiking in the Alps"
    fill_in "Description", with: "Have a ball hiking in the alps!"
    fill_in "Price", with: "1000"
    fill_in "Rental type", with: "Hiking"
    click_button "Create Rental"

    assert_equal "/owner/dashboard", current_path
    assert page.has_content?("The rental 'Hiking in the Alps' has been created")

    visit rentals_path
    assert page.has_content?("Hiking in the Alps")
  end

  test "user cannot access new rental path" do
    create_and_login_user
    visit new_owner_rental_path

    assert page.has_content?("The page you were looking for doesn't exist")
    refute page.has_content?("Add a New Rental")
  end
end
