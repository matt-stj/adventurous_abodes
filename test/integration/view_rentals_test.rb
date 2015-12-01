require "test_helper"

class ViewRentalsTest < ActionDispatch::IntegrationTest
  test "visitor can see rentals" do
    create_rentals(2, "Hiking")
    visit rentals_path

    assert_equal rentals_path, current_path

    within("h1") do
      assert page.has_content?("Rental")
    end

    within("#hiking_the_alps_1") do
      assert page.has_content?("Hiking the Alps 1")
      assert page.has_content?("Go hike the alps! 1")
      assert page.has_content?("$1,001")
    end

    within("#hiking_the_alps_2") do
      assert page.has_content?("Hiking the Alps 2")
      assert page.has_content?("Go hike the alps! 2")
      assert page.has_content?("$1,002")
    end
  end

  test "visitor can view rental details" do
    create_rentals(1, "Hiking")
    rental = Activity.find_by_name("Hiking").rentals.first
    visit "/hiking"
    click_link "Details"

    assert_equal rental_path(rental), current_path

    within("h1") do
      assert page.has_content?("Hiking the Alps 1")
    end

    within("p.rental-description") do
      assert page.has_content?("Go hike the alps! 1")
    end

    assert page.has_content?("$1,001")
  end
end
