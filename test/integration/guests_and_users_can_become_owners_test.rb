require 'test_helper'

class GuestsAndUsersCanBecomeOwnersTest < ActionDispatch::IntegrationTest
  test "guest can apply to become an owner from nav link" do
    create_roles
    visit '/'
    click_link 'Become A Host'

    assert_equal new_owner_path, current_path

    fill_in "Username", with: "Nicole@gmail.com"
    fill_in "Name", with: "Nicole"
    fill_in "Password", with: "password"
    click_button "Apply to Be Host"

    assert_equal '/pending', current_path
    assert page.has_content?("Thank You for your Application")
  end

  test "user can apply to become an owner from nav link" do
    create_and_login_user
    visit '/'
    click_link 'Become A Host'

    assert_equal '/pending', current_path
    assert page.has_content?("Thank You for your Application")
  end

  test "user can apply to become an owner from their profile" do
    create_and_login_user
    visit '/dashboard'
    click_link 'Apply to Be A Host'

    assert_equal '/pending', current_path
    assert page.has_content?("Thank You for your Application")
  end


end
