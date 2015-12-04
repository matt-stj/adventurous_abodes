require 'test_helper'

class PlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test "A platform admin can see pending requests to become a new owner/host" do
    skip
    platform_admin = create_platform_admin
    login_platform_admin

    visit 'admin/dashboard'

    assert page.has_content?("Pending Owner Requests")
  end

  test "A platform can visit a page where they can see all owners and their current statuses" do
    create_user
    platform_admin = create_platform_admin
    create_active_owners(2)
    create_inactive_owners(3)

    login_platform_admin

    visit 'admin/dashboard'

    click_link("Manage Owners")

    assert_equal admin_owners_path, current_path
    assert page.has_content?("Admin Owners Index")
    # asssert page.has_content?("")
    save_and_open_page
  end

  test "Only a platform admin can view the dashboard" do
    skip
  end

  ## Should there be a default status for active owner?  And it changes when an admin turns them into an owner?

end
