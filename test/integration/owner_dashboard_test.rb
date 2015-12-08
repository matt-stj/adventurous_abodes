require "test_helper"

class OwnerDashboardTest < ActionDispatch::IntegrationTest
  test "owner can login and access owner dashboard path" do
    create_and_login_owner

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

  test "owner can update account details" do
    create_and_login_owner
    click_link "Edit Account"

    fill_in "Username", with: "acareaga"
    fill_in "Password", with: "password"
    click_button "Update Account"

    assert page.has_content?("acareaga")
  end

  test "owner can delete their account" do
    create_and_login_owner
    click_link "Delete Account"

    assert_equal root_path, current_path
  end

end
