require "test_helper"

class ViewRentalsTest < ActionDispatch::IntegrationTest
  test "guest can view rentals" do
    create_rentals(1, "Castle")
    visit rentals_path

    assert page.has_content?("Rental")
    assert page.has_content?("Castle 1")
    assert page.has_content?("$1,001")
  end

  test "guest can view rentals sorted by rental_type" do
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path
    click_link "Castle"

    assert_equal "/rental_types/castle", current_path
    within("h1") do
      assert page.has_content?("Castle")
      refute page.has_content?("Igloo")
    end
  end

  test "logged in user can view rentals" do
    create_and_login_user
    create_rentals(1, "Castle")
    visit rentals_path

    assert page.has_content?("Rental")
    assert page.has_content?("Castle 1")
    assert page.has_content?("$1,001")
  end

  test "logged in user can view rentals sorted by rental_type" do
    create_and_login_user
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path
    click_link "Castle"

    assert_equal "/rental_types/castle", current_path
    within("h1") do
      assert page.has_content?("Castle")
      refute page.has_content?("Igloo")
    end
  end

  test "guest can view rentals by owner" do
    owner = User.create!(username: "owner", name: "owner", password: "password", role: 1)

    2.times do |i|
      i += 1
      rental_type = RentalType.find_or_create_by(name: "Castle")
      rental_type.rentals.create(name: "Castle #{i}",
                                 description: "No dragons allowed. #{i}",
                                 price: 1000 + i)
      owner.rentals << Rental.last(i)
    end

    visit owner_path(owner)
    assert page.has_content?("Rentals")
    assert page.has_content?("Castle")
  end
end
