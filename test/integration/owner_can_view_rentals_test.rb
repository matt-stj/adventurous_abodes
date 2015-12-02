require 'test_helper'

class OwnerCanViewRentalsTest < ActionDispatch::IntegrationTest
  test "owner can view all items" do
    create_rentals(2, "Hiking")

    login_owner

    assert owner_dashboard_path, current_path

    click_link ("View All Rentals")

    assert "/owner/rentals", current_path

    assert page.has_content?("Rentals")
    assert page.has_content?("Hiking")
    assert page.has_content?("Go hike the alps")
    assert page.has_content?("ACTIVE")
    assert page.has_button?("Edit")
  end
end
