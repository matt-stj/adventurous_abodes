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

  test "platform admin sees list of pending guest-to-owner requests" do
    create_roles
    visit '/'
    click_link 'Become A Host'
    fill_in "Username", with: "Nicole@gmail.com"
    fill_in "Name", with: "Nicole"
    fill_in "Password", with: "password"
    click_button "Apply to Be Host"
    click_link 'Logout'

    create_platform_admin
    login_platform_admin

    visit '/admin/dashboard'

    within(".pending-owners") do
      assert page.has_content?("Nicole@gmail.com")
      assert page.has_content?("Approve")
      assert page.has_content?("Deny")
    end
  end

  test "platform admin sees list of pending user-to-owner requests" do
    create_and_login_user
    visit '/dashboard'
    click_link 'Apply to Be A Host'
    click_link 'Logout'

    create_platform_admin
    login_platform_admin

    visit '/admin/dashboard'

    within(".pending-owners") do
      assert page.has_content?("cole")
      assert page.has_content?("Approve")
      assert page.has_content?("Deny")
    end
  end

  test "platform admin can approve a pending request" do
    create_and_login_user
    visit '/dashboard'
    click_link 'Apply to Be A Host'
    click_link 'Logout'

    create_platform_admin
    login_platform_admin

    visit '/admin/dashboard'
    click_link 'Manage Owners'

    within(".owners") do
      refute page.has_content?("cole")
    end

    visit '/admin/dashboard'
    click_link 'Approve'

    within(".pending-owners") do
      refute page.has_content?("cole")
    end

    click_button 'Manage Owners'

    within(".owners") do
      assert page.has_content?("cole")
    end
  end

  test "platform admin can deny a pending request" do
    create_and_login_user
    visit '/dashboard'
    click_link 'Apply to Be A Host'
    click_link 'Logout'

    create_platform_admin
    login_platform_admin

    visit '/admin/dashboard'
    click_link 'Manage Owners'

    within(".owners") do
      refute page.has_content?("cole")
    end

    visit '/admin/dashboard'
    click_link 'Deny'

    within(".pending-owners") do
      refute page.has_content?("cole")
    end

    click_button 'Manage Owners'

    within(".owners") do
      refute page.has_content?("cole")
    end
  end
end
