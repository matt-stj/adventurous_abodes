require "test_helper"

class VisitorSeesRentalsByRentalTypesTest < ActionDispatch::IntegrationTest
  test "visitor can see list of rental_types" do
    create_rentals(2, "Castle")
    create_rentals(2, "Shack")

    visit rentals_path

    assert page.has_content?("Castle")
    assert page.has_content?("Shack")
  end
end
