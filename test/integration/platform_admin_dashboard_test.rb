require 'test_helper'

class PlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test "A platform admin can see pending requests to become a new owner/host" do
    skip
    platform_admin = create_platform_admin
    login_platform_admin

    visit 'admin/dashboard'

    assert page.has_content?("Pending Owner Requests")
  end

  test "A platform admin can visit a page where they can see all owners and their current statuses" do
    create_user
    platform_admin = create_platform_admin
    create_active_owners(2)
    create_inactive_owners(3)

    login_platform_admin

    visit 'admin/dashboard'

    click_link("Manage Owners")

    assert_equal admin_owners_path, current_path
    assert page.has_content?("Admin Owners Index")
    within(".owners") do
      assert page.has_content?("active")
      assert page.has_content?("inactive")
    end
  end

  test "A platform admin can change an owner's current status from active to inactive" do
    create_user
    platform_admin = create_platform_admin
    owner = create_active_owners(1)

    assert_equal "active", owner.owner_status

    login_platform_admin

    visit 'admin/dashboard'

    click_link("Manage Owners")

    assert_equal admin_owners_path, current_path

    within(".owners") do
      assert page.has_content?("active")
      refute page.has_content?("inactive")
    end

    click_link("Make Inactive")
    within(".owners") do
      assert page.has_content?("inactive")
    end
  end

  test "A platform admin can change an owner's current status from inactive to active" do
    create_user
    platform_admin = create_platform_admin
    owner = create_inactive_owners(1)

    assert_equal "inactive", owner.owner_status

    login_platform_admin

    visit 'admin/dashboard'

    click_link("Manage Owners")

    assert_equal admin_owners_path, current_path

    within(".owners") do
      assert page.has_content?("inactive")
    end

    click_link("Make Active")
    save_and_open_page
    within(".owners") do
      assert page.has_content?("active")
    end
  end

  test "Guest can't view the platform admin dashboard" do

    visit 'admin/dashboard'

    assert page.has_content?("Back Off")
  end

  test "User can't view the platform admin dashboard" do
    create_and_login_user
    visit 'admin/dashboard'

    assert page.has_content?("Back Off")
  end

  test "Store Owner can't view the platform admin dashboard" do
    create_owners(1)
    login_owner

    visit admin_dashboard_path

    assert page.has_content?("Back Off")
  end

end
