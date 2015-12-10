require "test_helper"

class ViewRentalsTest < ActionDispatch::IntegrationTest
  test "guest can view rentals" do
    create_rentals(1, "Castle")
    visit rental_types_path

    assert page.has_content?("Rental")
    assert page.has_content?("Name 1")
    assert page.has_content?("$1,001")
  end

  test "guest can view rentals sorted by rental_type" do
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path

    within '.browser-default' do
      find("option[value='Castle']").click
    end


    within('.displayed-rentals') do
      assert page.has_content?("Name 1")
      refute page.has_content?("Igloo")
    end
  end

  test "logged in user can view rentals" do
    create_and_login_user
    create_rentals(1, "Castle")
    visit rental_types_path

    assert page.has_content?("Rental")
    assert page.has_content?("Name 1")
    assert page.has_content?("$1,001")
  end

  test "logged in user can view rentals sorted by rental_type" do
    create_and_login_user
    visit rental_types_path
    create_rentals(1, "Castle")
    create_rentals(1, "Igloo")
    visit rental_types_path

    within '.browser-default' do
      find("option[value='Castle']").click
    end


    within('.displayed-rentals') do
      assert page.has_content?("Name 1")
      refute page.has_content?("Igloo")
    end
  end

  test "guest can view rentals by owner" do
    create_rentals(1, "Castle")
    visit owner_path(User.last)

    assert page.has_content?("Rentals")

    assert page.has_content?("Name 1")
  end

  test "logged in user cannot view rentals that have been retired" do
    create_and_login_user
    create_rentals(1, "Castle")
    Rental.last.retire
    visit rental_path(Rental.last)

    assert page.has_content?("Unavailable")
    refute page.has_content?("Reserve it!")
  end
end
