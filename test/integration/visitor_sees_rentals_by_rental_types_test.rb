require "test_helper"

class VisitorSeesRentalsByRentalTypesTest < ActionDispatch::IntegrationTest
  test "visitor can see list of rental_types" do
    create_rentals(2, "Hiking")
    create_rentals(2, "Fishing")

    visit rentals_path

    assert page.has_content?("Hiking")
    assert page.has_content?("Fishing")
  end
end
