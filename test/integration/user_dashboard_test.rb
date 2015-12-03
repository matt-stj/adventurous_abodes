require "test_helper"

class UserDashboardTest < ActionDispatch::IntegrationTest
  test "user must be logged in to view dashboard" do
    visit dashboard_path

    assert_equal root_path, current_path
    assert page.has_content?("Back Off!")
  end

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

  test "user can edit account but must have name" do
    create_and_login_user
    assert page.has_content?("Welcome")
    click_link "Edit Account"
    fill_in "Username", with: ""
    fill_in "Password", with: "pass"
    click_button "Update Account"

    assert page.has_content?("Username can't be blank")
  end

  test "user can delete their account" do
    create_and_login_user
    assert page.has_content?("Welcome, Nicole")
    click_link "Delete Account"

    assert root_path, current_path
    assert page.has_content?("Pursue Your Passion")
  end

end
