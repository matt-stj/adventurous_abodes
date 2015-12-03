require "test_helper"

class UserDashboardTest < ActionDispatch::IntegrationTest

  test "user can edit account details and password" do
    create_and_login_user
    assert page.has_content?("Welcome, ")
    click_link "Edit Account"
    fill_in "Username", with: "aaron"
    fill_in "Password", with: "pass"
    click_button "Update Account"

    assert dashboard_path, current_path
    assert page.has_content?("aaron")
  end

  test "user can delete their account" do
    create_and_login_user
    assert page.has_content?("Welcome, Nicole")
    click_link "Delete Account"

    assert root_path, current_path
    assert page.has_content?("Pursue Your Passion")
  end
end
