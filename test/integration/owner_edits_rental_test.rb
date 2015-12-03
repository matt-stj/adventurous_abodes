require 'test_helper'

class OwnerEditsRentalTest < ActionDispatch::IntegrationTest
  test "owner can edit an existing rental" do
    skip
    create_rentals(1, "Hiking")
    login_owner

    click_link ("View All Rentals")

    assert owners_rentals_path, current_path
    assert page.has_content?("Hiking")

    click_button "Edit"

    assert "/owners/rentals/#{Rental.first.id}/edit", current_path

    fill_in "Name", with: "Skiing"
    fill_in "Price", with: "650"
    fill_in "Status", with: "Active"

    click_button "Update Rental"

    assert owners_dashboard_path, current_path
  end
end
