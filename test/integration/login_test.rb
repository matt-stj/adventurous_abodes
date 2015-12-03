require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest
  test "a registered user can login" do
    create_and_login_user

    assert_equal "/dashboard", current_path
    assert page.has_content?("Logged in as Nicole")
  end

  test "user cannot see login forms if already logged in" do
    create_and_login_user
    visit root_path
    refute page.has_content?("Login to Your Account")
    visit login_path

    refute page.has_content?("Login to Your Account")
    assert page.has_content?("You are already logged in as Nicole.")
  end

  test "a registered user can logout" do
    create_and_login_user

    click_link "Logout"
    assert page.has_content?("Login")
    refute page.has_content?("Logout")
  end
end
