require "test_helper"

class OwnerDashboardTest < ActionDispatch::IntegrationTest
  test "owner can login and access owner dashboard path" do
    login_owner

    assert_equal owners_dashboard_path, current_path
    assert page.has_content?("Owner Dashboard")
  end

  test "user cannot access owner dashboard" do
    create_and_login_user

    visit owners_dashboard_path
    assert page.has_content?("Back Off")
  end

  test "unregistered user cannot access owner dashboard" do
    visit login_path
    assert page.has_content?("Login")
    visit '/owners/dashboard'

    assert page.has_content?("Back Off")
  end

  test "owner sees their rentals on the dashboard" do
    login_owner

    click_link("Add Rental")

    assert_equal new_owners_rental_path, current_path
    assert page.has_content?("Add a New Rental")

    fill_in "Name", with: "Attic"
    fill_in "Description", with: "Have a ball hiking in the alps!"
    fill_in "Price", with: "1000"
    fill_in "Rental type", with: "Hiking"
    click_button "Create Rental"

    assert_equal owners_dashboard_path, current_path

    assert page.has_content?("Attic")
    assert page.has_link?("edit")
  end

  test "owner can update account details but not other users" do
    skip
    login_owner
    click_link "Edit Account"

    assert_equal owners_dashboard_path, current_path

    fill_in "Username", with: "acareaga"
    fill_in "Password", with: "password"
    click_button "Update Account"

    assert page.has_content?("acareaga")
  end

  test "owner can delete their account" do
    skip
    login_owner
    click_link "Delete Account"

    assert_equal root_path, current_path
  end
end
