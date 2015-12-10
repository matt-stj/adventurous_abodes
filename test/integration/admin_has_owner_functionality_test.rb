require 'test_helper'

class AdminHasOwnerFunctionalityTest < ActionDispatch::IntegrationTest
  test "admin can access an owner's dashboard" do
    create_owners(1, "active")
    owner = User.last
    create_platform_admin
    login_platform_admin
    visit admin_owners_path
    click_link "owner0"

    assert_equal admin_owner_path(owner), current_path
    assert page.has_content?(owner.username)
    assert page.has_content?("Dashboard")
  end

  test "admin can see and edit an owner's rentals" do
    create_rentals(1, "Castle")
    owner = User.last
    create_platform_admin
    login_platform_admin
    visit admin_owner_path(owner)
    assert page.has_content?("Name 1")
    click_link "edit"
    fill_in "Name", with: "New Castle"
    fill_in "Description", with: "New description"
    fill_in "Price", with: 1200

    click_button "Submit"

    assert_equal admin_owner_path(owner), current_path
    refute page.has_content?("Castle 1")
    assert page.has_content?("New Castle")
  end

  test "admin can see and update an owner's details" do
    create_owners(1, "active")
    owner = User.last
    create_platform_admin
    login_platform_admin
    visit admin_owner_path(owner)
    assert page.has_content?("owner0")
    click_link "Edit Owner's Profile"

    fill_in "Username", with: "new_username@example.com"
    fill_in "Name", with: "NewName"
    fill_in "Owner status", with: "active"
    click_button "Update Owner's Profile"

    assert_equal admin_owner_path(owner), current_path
    refute page.has_content?("owner0")
    assert page.has_content?("new_username@example.com")
  end

  test "admin must update an owner with correct details" do
    create_owners(1, "active")
    owner = User.last
    create_platform_admin
    login_platform_admin
    visit admin_owner_path(owner)
    click_link "Edit Owner's Profile"
    fill_in "Username", with: ""
    fill_in "Name", with: "User"
    fill_in "Owner status", with: "active"
    click_button "Update Owner's Profile"

    assert page.has_content?("Username can't be blank")
  end
end
