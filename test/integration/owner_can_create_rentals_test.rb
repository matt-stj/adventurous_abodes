require "test_helper"

class OwnerCanCreateRentalsTest < ActionDispatch::IntegrationTest
  test "owner can create rental" do
    login_owner

    click_link("Add Rental")

    assert_equal new_owners_rental_path, current_path
    assert page.has_content?("Add a New Rental")

    fill_in "Name", with: "Brick Castle"
    fill_in "Description", with: "Have a ball sleeping in the alps!"
    fill_in "Price", with: "1000"
    fill_in "Rental type", with: "Castle"
    click_button "Create Rental"

    assert_equal "/owners/dashboard", current_path
    assert page.has_content?("The rental 'Brick Castle' has been created")
    assert page.has_content?("Brick Castle")
  end

  test "user cannot access new rental path" do
    create_and_login_user
    visit new_owners_rental_path

    assert page.has_content?("Back Off")
    refute page.has_content?("Add a New Rental")
  end
end
