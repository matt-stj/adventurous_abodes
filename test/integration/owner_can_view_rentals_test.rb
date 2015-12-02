require 'test_helper'

class OwnerCanViewRentalsTest < ActionDispatch::IntegrationTest
  test "owner can view all items" do
    create_rentals(2, "Castle")
    login_owner
    click_link ("View All Rentals")

    assert "/owner/rentals", current_path
    assert page.has_content?("Rentals")
    assert page.has_content?("Castle")
    assert page.has_content?("ACTIVE")
    assert page.has_button?("Edit")
  end
end
